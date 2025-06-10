import 'package:hive_flutter/hive_flutter.dart';

class LocalStorageService {
  static const _userBox = 'userBox';
  static const _userEmailKey = 'userEmail';

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(_userBox);
  }

  static Future<void> saveUserData(String email) async {
    final box = await Hive.openBox(_userBox); // افتح الصندوق إذا لم يكن مفتوحًا
    await box.put(_userEmailKey, email);
  }

  static Future<String> getUserData() async {
    final box = await Hive.openBox(_userBox); // افتح الصندوق إذا لم يكن مفتوحًا
    return box.get(_userEmailKey, defaultValue: '');
  }

  static Future<void> clearUserData() async {
    try {
      final box =
          await Hive.openBox(_userBox); // افتح الصندوق إذا لم يكن مفتوحًا
      if (box.isOpen) {
        await box.clear(); // مسح البيانات
        print('User data cleared successfully');
      } else {
        print('Box is not open');
      }
    } catch (e) {
      print("Error clearing user data: $e");
    }
  }
}
