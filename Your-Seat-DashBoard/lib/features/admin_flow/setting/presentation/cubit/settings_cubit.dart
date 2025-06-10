import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourseatgraduationproject/utils/app_logs.dart';

import '../../../../../data/local_storage_service/local_storage_service.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial());
  TextEditingController cinemaNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController managerController = TextEditingController();
  String? selectedCountry;

  String? cinemaId;
  num? lat;
  num? lng;

  static SettingsCubit get(context) => BlocProvider.of<SettingsCubit>(context);
  Future<void> getCinemaData() async {
    cinemaId = extractUsername(LocalStorageService.getUserData() ?? "");
    //  cinemaId = "Plaza Cinema";
    emit(SettingsLoading());
    try {
      final cinemaRef = FirebaseFirestore.instance.collection('Cinemas');
      // البحث باستخدام cinemaId كمعرف المستند مباشرة
      final docSnapshot = await cinemaRef.doc(cinemaId).get();

      if (docSnapshot.exists) {
        // إذا وجدت السينما، املأ البيانات
        final data = docSnapshot.data() as Map<String, dynamic>;
        cinemaNameController.text = data['name'] ?? '';
        phoneController.text = data['phone'] ?? '';
        emailController.text = data['mail'] ?? '';
        managerController.text = data['manager'] ?? '';
        selectedCountry = data['country'] ?? "Cairo";

        lat = data['lat'];
        lng = data['lng'];
        emit(const SettingsLoaded());
      } else {
        selectedCountry = "Cairo";
        // إذا لم يتم العثور على السينما، قم بتحميل الصفحة بدون بيانات
        emit(const SettingsLoaded());
      }
    } catch (e) {
      emit(SettingsError('Error getting cinema data: $e'));
    }
  }

  Future<void> addOrUpdateCinemaData() async {
    cinemaId = extractUsername(LocalStorageService.getUserData() ?? "");
    // cinemaId = "Plaza Cinema";
    emit(SettingsLoading());
    try {
      final cinemaRef = FirebaseFirestore.instance.collection('Cinemas');

      // نتأكد إن cinemaId مش فاضي أو null
      if (cinemaId == null) {
        throw Exception("cinemaId cannot be null or empty");
      }

      // البحث باستخدام cinemaId كمعرف المستند مباشرة
      final querySnapshot = await cinemaRef.doc(cinemaId).get();

      Map<String, dynamic> cinemaData = {
        'rating': 0,
        'rating_count': 0,
        'name': cinemaNameController.text,
        'phone': phoneController.text,
        'mail': emailController.text,
        'manager': managerController.text,
        'country': selectedCountry,
        'lat': lat,
        'lng': lng
      };

      if (querySnapshot.exists) {
        await cinemaRef.doc(cinemaId).update(cinemaData);
        AppLogs.debugLog("Updated document with ID: $cinemaId");
      } else {
        await cinemaRef.doc(cinemaId).set(cinemaData);
        AppLogs.debugLog("Added document with ID: $cinemaId");
      }

      emit(const SettingsLoaded());
    } catch (e) {
      emit(SettingsError('Error adding/updating cinema data: $e'));
    }
  }

  String extractUsername(String email) {
    AppLogs.errorLog(email.toString());

    // نفترض إن الإيميل دايماً بينتهي بـ @admin.com
    if (email.contains("@")) {
      // بنشيل الجزء بتاع @admin.com ونرجع الاسم
      return email.substring(0, email.indexOf("@admin.com"));
    } else {
      return "Invalid email format"; // لو الإيميل مش بالصيغة المطلوبة
    }
  }
}
