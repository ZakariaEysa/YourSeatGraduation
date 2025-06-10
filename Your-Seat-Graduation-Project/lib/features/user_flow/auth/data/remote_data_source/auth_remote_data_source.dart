import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../../../data/hive_keys.dart';
import '../../../../../data/hive_storage.dart';
import '../model/google_user_model.dart';
import '../model/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<GoogleUserModel> signInWithGoogle();
  Future<GoogleUserModel> signInWithFacebook();
  Future<String> checkUserExists(String userId, String password);
  Future<void> checkUserExistsR(String phone);
  Future<void> saveUserToFireStore({
    required UserModel userModel,
  });
  Future<void> signInWithPhoneNumber(
      String phoneNumber, Function(String) onCodeSent);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  AuthRemoteDataSourceImpl(this._auth, this._googleSignIn);

  @override
  Future<GoogleUserModel> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw Exception('User canceled the sign-in process');
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      final user = userCredential.user;

      if (user != null) {
        if (HiveStorage.get(HiveKeys.role) == null) {
          HiveStorage.set(
            HiveKeys.role,
            Role.google.toString(),
          );
        }
        // AppLogs.infoLog(user.toString()); // Removed: was used for logging user

        // AppLogs.infoLog(GoogleUserModel.fromFirebaseUser(user).toString()); // Removed: was used for logging GoogleUserModel
        // AppLogs.debugLog(GoogleUserModel.fromFirebaseUser(user).toString()); // Removed: was used for logging GoogleUserModel debug

        return GoogleUserModel.fromFirebaseUser(user);
      } else {
        throw Exception('Google sign-in failed');
      }
    } catch (e) {
      throw Exception('Error during Google sign-in: $e');
    }
  }

  @override
  Future<GoogleUserModel> signInWithFacebook() async {
    final result = await FacebookAuth.instance.login();
    if (result.status == LoginStatus.success) {
      final credential =
          FacebookAuthProvider.credential(result.accessToken!.token);
      final userCredential = await _auth.signInWithCredential(credential);
      return GoogleUserModel.fromFirebaseUser(userCredential.user!);
    } else {
      throw Exception('Facebook login failed');
    }
  }

  @override
  Future<String> checkUserExists(String userEmail, String password) async {
    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(userEmail)
        .get();

    if (userDoc.exists) {
      if (userDoc.get("password") == password) {
        // await HiveStorage.saveDefaultUser(UserModel(name: (userDoc.get('name')), email: userEmail, password: password, dateOfBirth: userDoc.get("dateOfBirth"),gender: userDoc.get("gender"),image: userDoc.get("image"),location: userDoc.get("location") ));
        await HiveStorage.saveDefaultUser(UserModel(
            name: (userDoc.get('name')),
            email: userEmail,
            password: password,
            dateOfBirth: userDoc.get("dateOfBirth"),
            gender: userDoc.get("gender"),
            image: userDoc.get("image"),
            location: userDoc.get("location")));

        return "LoginSuccessful";
      }
    }

    return "User does not exist or password is incorrect";

    // throw Exception('User does not exist or password is incorrect');
  }

  @override
  Future<void> checkUserExistsR(String email) async {
    try {
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(email)
          .get()
          .timeout(Duration(seconds: 2));

      if (userDoc.exists) {
        throw "User already exists";
      }
    } on TimeoutException {
      // Handle timeout exception
      throw "Request timed out. Please check your network connection.";
    } on FirebaseException catch (e) {
      // Handle Firebase specific exceptions
      throw "Firebase error: ${e.message}";
    } catch (e) {
      // Handle other exceptions
      if (e == "User already exists") {
        rethrow; // Re-throw the specific error
      } else {
        throw "Something went wrong. Please check your network.";
      }
    }
  }

  @override
  Future<void> saveUserToFireStore({
    required UserModel userModel,
  }) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.email)
        .set({
      'name': userModel.name,
      'email': userModel.email,
      //'phone': "0$phone",
      'password': userModel.password,
      'dateOfBirth': userModel.dateOfBirth,
      'gender': userModel.gender,
      'image': userModel.image,
      'location': userModel.location,
    });
  }

  @override
  Future<void> signInWithPhoneNumber(
      String phoneNumber, Function(String) onCodeSent) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        throw Exception("Verification failed: ${e.message}");
      },
      codeSent: (String verificationId, int? resendToken) {
        onCodeSent(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}
