import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_otp_auth/email_otp_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../utils/notifications_manager.dart';
import '../../data/model/google_user_model.dart';
import '../../data/model/user_model.dart';
import '../../domain/repos/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  static AuthCubit get(context) => BlocProvider.of<AuthCubit>(context);
  final AuthRepo authRepo;
  UserModel? userModel;
  AuthCubit(this.authRepo) : super(AuthInitial());
  GlobalKey<FormState> formKeyLogin = GlobalKey();
  GlobalKey<FormState> formKeyRegister = GlobalKey();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController emailController = TextEditingController();

  String? selectedMonth;
  int? selectedDay;
  int? selectedYear;

  Future<void> signInWithGoogle() async {
    emit(AuthLoading());
    final response = await authRepo.signInWithGoogle();

    response.fold(
        // (failure) => emit(GoogleAuthError(failure.errorMsg)),

        (failure) => emit(GoogleAuthError(
            "Sorry there was an error , please try again later")), (user) {
      NotificationsManager.showLocalNotification(
          "Logged In Successfully ✅",
          "Welcome Back !",
          " تم تسجيل الدخول ✅بنجاح ",
          "مرحباً عزيزي المستخدم");
      emit(GoogleAuthSuccess(user));
    });
  }

  Future<void> loginWithFacebook() async {
    emit(AuthLoading());
    final response = await authRepo.signInWithFacebook();

    response.fold(
      (failure) => emit(FacebookAuthError(failure.errorMsg)),
      (user) => emit(FacebookAuthSuccess(user)),
    );
  }

  Future<void> validateUser(String userId, String password) async {
    emit(AuthLoading());
    var response = await authRepo.checkUserExists(userId, password);

    response.fold(
      // (failure) => emit(UserValidationError("Sorry there was an error , please try again later")),
      (failure) => emit(UserValidationError(
          "something went wrong please check your network")),

      (message) {
        if (message == "LoginSuccessful") {
          emit(UserValidationSuccess(message));
          NotificationsManager.showLocalNotification(
              "Logged In Successfully ✅",
              "Welcome Back !",
              " تم تسجيل الدخول ✅بنجاح ",
              "مرحباً عزيزي المستخدم");
        } else {
          emit(UserValidationError(message));

          //emit(  UserValidationError("Sorry there was an error , please try again later"));
        }
      },
    );
  }

  Future<void> registerUser({
    required UserModel userModel,
  }) async {
    // try {
    emit(AuthLoading());
    //AppLogs.successLog("messageee");

    try {
      await authRepo.checkUserExistsR(userModel.email);
    } catch (e) {
      // BotToast.showText(text: " something went wrong please check your network");
      emit(AuthError(e.toString()));
// emit(AuthInitial());
      return;
    }
    sendOtp(userModel.email);
    this.userModel = userModel;

    emit(AuthSuccess());
    // } on FirebaseAuthException catch (e) {
    //   emit(AuthError(e.message ?? ""));
    // } catch (e) {
    //   emit(AuthError(e.toString()));
    // }
  }

  void sendOtp(String email) async {
    var res = await EmailOtpAuth.sendOTP(email: email);

    if (res["message"] == "Email Send") {
      //AppLogs.successLog("OTP sent successfully to $email");
    } else {
      //AppLogs.successLog("Failed to send OTP to $email");
    }
  }

  Future<void> verifyedSendOtp() async {
    //AppLogs.successLog(userModel.toString());
    await authRepo.saveUser(
        userModel: userModel ??
            UserModel(name: "", email: "", password: "", dateOfBirth: ""));
    final String name = userModel?.name ?? "";
    NotificationsManager.showLocalNotification("Registered Successfully ✅",
        "Hello! $name", " ✅تم التسجيل بنجاح ", "مرحباً عزيزي المستخدم");
  }

  Future<void> updateUserPassword(String userEmail, String newPassword) async {
    try {
      emit(UpdatePasswordLoading());
      const timeoutDuration = Duration(seconds: 5);
      final usersCollection = FirebaseFirestore.instance.collection('users');
      await Future.any([
        usersCollection.doc(userEmail).update({
          'password': newPassword,
        }),
        Future.delayed(timeoutDuration)
            .then((_) => throw ('Request timed out')),
      ]);

      emit(UpdatePasswordSuccess());
    } on TimeoutException catch (_) {
      emit(UpdatePasswordError("Request timed out"));
    } catch (e) {
      emit(UpdatePasswordError("Something went wrong"));
    }
  }
}
