import 'package:dartz/dartz.dart';

import '../../../../../services/failure_service.dart';
import '../../data/model/google_user_model.dart';
import '../../data/model/user_model.dart';

abstract class AuthRepo {
  Future<Either<FailureService, GoogleUserModel>> signInWithGoogle();
  Future<Either<FailureService, GoogleUserModel>> signInWithFacebook();
  Future<Either<FailureService, String>> checkUserExists(
      String userId, String password);
  Future<void> checkUserExistsR(String email);
  Future<void> saveUser({
    required UserModel userModel,
  });
  Future<void> sendOtp(String phoneNumber, Function(String) onCodeSent);
}
