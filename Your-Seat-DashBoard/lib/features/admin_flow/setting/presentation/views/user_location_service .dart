import 'dart:html';

import 'package:flutter/material.dart';
import 'package:yourseatgraduationproject/utils/app_logs.dart';

import '../cubit/settings_cubit.dart';

class UserLocationService {
  // دالة لجلب الموقع الحالي للـ User
  Future<Map<String, double>?> getCurrentLocation(BuildContext context) async {
    try {
      final geo = window.navigator.geolocation;
      final position = await geo.getCurrentPosition();

      final lat = position.coords?.latitude;
      final lng = position.coords?.longitude;
      AppLogs.debugLog("Latitude: $lat, Longitude: $lng");

      if (lat != null && lng != null) {
        SettingsCubit.get(context).lat = lat;
        SettingsCubit.get(context).lng = lng;
      }
      return {'latitude': lat as double, 'longitude': lng as double};
    } catch (e) {
      print("Error getting location: $e");
      return null;
    }
  }
}
