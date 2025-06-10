import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

// import 'app_logs.dart';

/// فئة لإدارة أذونات التطبيق
class PermissionsManager {
  /// طلب جميع الأذونات الأساسية للتطبيق
  // static Future<void> requestAllPermissions() async {
  //   await requestCameraPermission();
  //   await requestStoragePermission();
  //   await requestLocationPermission();
  // }

  /// طلب إذن الكاميرا
  static Future<void> requestCameraPermission() async {
    final status = await Permission.camera.request();
    _logPermissionStatus('Camera', status);

    if (status.isPermanentlyDenied) {
      // AppLogs.errorLog('Camera permission permanently denied');
      await openAppSettings();
    }
  }

  /// طلب إذن التخزين
  static Future<void> requestStoragePermission() async {
    final status = await Permission.storage.request();
    _logPermissionStatus('Storage', status);

    if (status.isPermanentlyDenied) {
      // AppLogs.errorLog('Storage permission permanently denied');
      await openAppSettings();
    }
  }

  /// طلب إذن الموقع
  static Future<void> requestLocationPermission() async {
    final status = await Permission.locationWhenInUse.request();
    _logPermissionStatus('Location', status);

    if (status.isPermanentlyDenied) {
      // AppLogs.errorLog('Location permission permanently denied');
      await openAppSettings();
    }
  }

  /// التحقق من حالة خدمة الموقع وطلب الإذن إذا لزم
  static Future<bool> checkAndRequestLocationService() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // AppLogs.errorLog('Location services are disabled');
      await Geolocator.openLocationSettings();
      return false;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // AppLogs.errorLog('Location permissions are denied');
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // AppLogs.errorLog('Location permissions are permanently denied');
      await Geolocator.openAppSettings();
      return false;
    }

    return true;
  }

  /// الحصول على الموقع الحالي للمستخدم

  /// تسجيل حالة الإذن في سجل التطبيق
  static void _logPermissionStatus(
      String permissionName, PermissionStatus status) {
    if (status.isGranted) {
      // AppLogs.successLog('$permissionName permission granted');
    } else if (status.isDenied) {
      // AppLogs.errorLog('$permissionName permission denied');
    } else if (status.isPermanentlyDenied) {
      // AppLogs.errorLog('$permissionName permission permanently denied');
    } else if (status.isRestricted) {
      // AppLogs.errorLog('$permissionName permission restricted');
    } else if (status.isLimited) {
      // AppLogs.infoLog('$permissionName permission limited');
    }
  }

  void showCenteredSnackBar(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black.withOpacity(0.8),
      textColor: Colors.white,
      fontSize: 14.0,
    );
    // final context = navigatorKey.currentContext;
    // if (context == null) return;

    // final overlay = Overlay.of(context);
    // if (overlay == null) return;

    // final overlayEntry = OverlayEntry(
    //   builder: (context) => Center(
    //     child: Material(
    //       color: Colors.transparent,
    //       child: Container(
    //         padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
    //         decoration: BoxDecoration(
    //           color: Colors.black.withOpacity(0.8),
    //           borderRadius: BorderRadius.circular(8.r),
    //         ),
    //         child: Text(
    //           message,
    //           style: TextStyle(color: Colors.white, fontSize: 14.sp),
    //         ),
    //       ),
    //     ),
    //   ),
    // );

    // overlay.insert(overlayEntry);

    // Future.delayed(Duration(seconds: 3), () {
    //   overlayEntry.remove();
    // });
  }

  Future<Position?> getUserLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        showCenteredSnackBar(
            'Location services are disabled. Please enable them.');
        await Geolocator.openLocationSettings();
        return null;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          showCenteredSnackBar('Location permissions are denied.');
          return null;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        showCenteredSnackBar(
            'Location permissions are permanently denied. Please enable them from app settings.');
        await Geolocator.openAppSettings();
        return null;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // showCenteredSnackBar(
      //     'User location: ${position.latitude}, ${position.longitude}');
      return position;
    } catch (e) {
      // print('Error getting location: $e'); // Removed: was used for debugging location errors
      showCenteredSnackBar('Error getting location.');
      return null;
    }
  }
}
