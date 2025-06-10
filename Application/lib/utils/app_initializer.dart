import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bot_toast/bot_toast.dart';
import '../data/hive_storage.dart';
import '../data/hive_keys.dart';
import 'firebase_manager.dart';
import 'notifications_manager.dart';
import 'permissions_manager.dart';

class AppInitializer {
  static bool _isAppInitialized = false;
  static bool _isStorageInitialized = false;

  static bool get isAppInitialized => _isAppInitialized;

  static bool get isStorageInitialized => _isStorageInitialized;
  static Future<void> initializeEssentialParts() async {
    _isAppInitialized = false;
    // AppLogs.infoLog('Starting essential app initialization');

    await _safelySetScreenOrientation();
    await _safelyInitializeLocalStorage();

    _isAppInitialized = true;
    // AppLogs.successLog('Essential app initialization completed');
  }

  static Future<void> initializeRemainingAsyncTasks() async {
    // await _safelyRequestPermissions();
    await _safelyInitializeFirebase();
    await _safelyInitializeNotifications();
    await PermissionsManager.requestStoragePermission();
  }

  static Future<bool> _safelySetScreenOrientation() async {
    try {
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);

      // AppLogs.infoLog('Screen orientation set to portrait mode');
      return true;
    } catch (e) {
      // AppLogs.errorLog('Error setting screen orientation: $e');
      return false;
    }
  }

  static Future<bool> _safelyInitializeLocalStorage() async {
    try {
      await HiveStorage.init();
      _isStorageInitialized = true;

      _safelySetDefaultValue(HiveKeys.isDark, true);
      _safelySetDefaultValue(HiveKeys.passUserOnboarding, false);
      _safelySetDefaultValue(HiveKeys.isArabic, false);

      // AppLogs.infoLog('Local storage initialized with default values');
      return true;
    } catch (e) {
      _isStorageInitialized = false;
      // AppLogs.errorLog('Error initializing local storage: $e');
      return false;
    }
  }

  static Future<void> _safelyInitializeFirebase() async {
    try {
      await FirebaseManager.initializeFirebase();
      // AppLogs.infoLog('Firebase initialized successfully');
    } catch (e) {
      // AppLogs.errorLog('Error initializing Firebase: $e');
    }
  }

  static Future<void> _safelyInitializeNotifications() async {
    try {
      await NotificationsManager.initializeAllNotifications();
      // AppLogs.infoLog('Notifications initialized successfully');
    } catch (e) {
      // AppLogs.errorLog('Error initializing notifications: $e');
    }
  }

  static void _safelySetDefaultValue(String key, dynamic defaultValue) {
    try {
      if (!_isStorageInitialized) return;

      if (HiveStorage.get(key) == null) {
        HiveStorage.set(key, defaultValue);
        // AppLogs.debugLog('Set default value for $key: $defaultValue');
      }
    } catch (e) {
      // AppLogs.errorLog('Error setting default value for $key: $e');
    }
  }

  static void _showError(String message) {
    BotToast.showText(
      text: message,
      duration: const Duration(seconds: 3),
      contentColor: Colors.orange,
      contentPadding: const EdgeInsets.all(10),
    );
  }

  static void _showCriticalError(String message) {
    BotToast.showText(
      text: message,
      duration: const Duration(seconds: 5),
      contentColor: Colors.red[700]!,
      contentPadding: const EdgeInsets.all(10),
    );
  }
}
