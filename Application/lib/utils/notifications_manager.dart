import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:permission_handler/permission_handler.dart';
import '../features/user_flow/notification/notification_cubit/notification_cubit.dart';

/// فئة لإدارة الإشعارات المحلية فقط
class NotificationsManager {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static bool _notificationsEnabled = true; // مفعلة دائمًا في الحالة المحلية

  /// الحصول على حالة تفعيل الإشعارات
  static bool get areNotificationsEnabled => _notificationsEnabled;

  /// تهيئة الإشعارات المحلية فقط
  static Future<void> initializeAllNotifications() async {
    try {
      await requestNotificationPermission();

      // //appLogs.infoLog('Initializing local notifications only'); // Removed: was used for logging notifications initialization

      await initializeLocalNotifications();

      // //appLogs.infoLog('Local notifications initialized successfully'); // Removed: was used for logging notifications initialization success
    } catch (e) {
      // //appLogs.errorLog('Error initializing local notifications: $e'); // Removed: was used for logging notifications initialization error
      _showNotificationError(
          'حدث خطأ أثناء تهيئة الإشعارات المحلية، بعض الميزات قد لا تعمل.');
    }
  }

  static Future<void> requestNotificationPermission() async {
    final status = await Permission.notification.request();
    if (status.isGranted) {
      // //appLogs.infoLog("Notification permission granted"); // Removed: was used for logging notification permission granted
    } else {
      // //appLogs.errorLog("Notification permission denied"); // Removed: was used for logging notification permission denied
      _notificationsEnabled = false;
      _showNotificationError(
          'تم رفض إذن الإشعارات. الرجاء تفعيله من الإعدادات.');
    }
  }

  /// تهيئة إشعارات Flutter المحلية
  static Future<void> initializeLocalNotifications() async {
    try {
      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('@mipmap/ic_launcher');

      const InitializationSettings initializationSettings =
          InitializationSettings(
        android: initializationSettingsAndroid,
      );

      await _flutterLocalNotificationsPlugin.initialize(initializationSettings);

      // //appLogs.infoLog('Local notifications system is ready'); // Removed: was used for logging local notifications system ready
    } catch (e) {
      // //appLogs.errorLog('Error during local notification init: $e'); // Removed: was used for logging local notification init error
    }
  }

  /// عرض إشعار محلي
  static Future<void> showLocalNotification(
      String title, String body, String titleAr, String bodyAr) async {
    if (!_notificationsEnabled) {
      await requestNotificationPermission();
      if (!_notificationsEnabled) return;

      // //appLogs.infoLog('Notifications disabled, skipping notification'); // Removed: was used for logging notifications disabled
    }

    try {
      //appLogs.successLog("start showing");
      await NotificationCubit().addNotification(title, body, titleAr, bodyAr);
      //appLogs.successLog("end showing");

      const AndroidNotificationDetails androidDetails =
          AndroidNotificationDetails(
        'default_channel_id',
        'default_notifications',
        channelDescription: 'Local notifications channel',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
      );

      const NotificationDetails platformDetails =
          NotificationDetails(android: androidDetails);

      await _flutterLocalNotificationsPlugin.show(
        0,
        title,
        body,
        platformDetails,
        payload: 'Default_Sound',
      );

      // //appLogs.infoLog('Local notification shown: $title - $body'); // Removed: was used for logging local notification shown
    } catch (e) {
      // //appLogs.errorLog('Error showing local notification: $e'); // Removed: was used for logging local notification error
    }
  }

  /// عرض رسالة خطأ للمستخدم
  static void _showNotificationError(String message) {
    BotToast.showText(
      text: message,
      duration: const Duration(seconds: 3),
      contentColor: Colors.orange,
      contentPadding: const EdgeInsets.all(10),
    );
  }
}
