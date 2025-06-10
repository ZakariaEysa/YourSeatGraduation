import 'dart:convert';
import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

part 'google_user_model.g.dart'; // Required for Hive adapter generation

@HiveType(typeId: 1) // Ensure the typeId is unique in your app
class GoogleUserModel extends Equatable {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final String? password; // Optional, not directly tied to Firebase

  @HiveField(3)
  final String? dateOfBirth; // Optional, custom field

  @HiveField(4)
  final String? image; // Optional, sourced from photoURL in Firebase

  @HiveField(5)
  final String? gender; // Optional, sourced from photoURL in Firebase

  @HiveField(6)
  final String? location; // Optional, sourced from photoURL in Firebase

  const GoogleUserModel({
    required this.name,
    required this.email,
    this.password,
    this.dateOfBirth,
    this.image,
    this.gender,
    this.location,
  });

  // Factory constructor to create a GoogleUserModel from a Firebase User object
  static Future<GoogleUserModel> fromFirebaseUser(User user) async {
    String base64Image = '';

    if (user.photoURL != null && user.photoURL!.isNotEmpty) {
      base64Image = await convertImageToBase64(user.photoURL!);
    }

    return GoogleUserModel(
      name: user.displayName ?? 'Unknown',
      email: user.email ?? 'Unknown',
      password: "", // Firebase doesn't expose passwords
      dateOfBirth: "", // To be set manually if required
      image:
          base64Image.isNotEmpty ? base64Image : '', // Base64 or empty string
      gender: null, // To be set manually if required
      location: "", // To be set manually if required
    );
  }

  // Function to convert an image URL to Base64
  static Future<String> convertImageToBase64(String imageUrl) async {
    try {
      // تحميل الصورة كبيانات من الرابط
      final response = await http.get(Uri.parse(imageUrl));

      if (response.statusCode == 200) {
        // تحويل البيانات إلى Base64
        Uint8List imageBytes = response.bodyBytes;
        String base64String = base64Encode(imageBytes);
        return base64String;
      } else {
        throw Exception('فشل تحميل الصورة');
      }
    } catch (e) {
      // print('Error: $e'); // Removed: was used for debugging errors in GoogleUserModel
      return '';
    }
  }

  @override
  List<Object?> get props =>
      [name, email, password, dateOfBirth, image, gender, location];
}
