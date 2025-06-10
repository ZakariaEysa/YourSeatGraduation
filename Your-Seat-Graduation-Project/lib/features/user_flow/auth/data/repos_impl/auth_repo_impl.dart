import 'package:dartz/dartz.dart';

import '../../../../../data/hive_storage.dart';
import '../../../../../services/failure_service.dart';
import '../../domain/repos/auth_repo.dart';
import '../model/google_user_model.dart';
import '../model/user_model.dart';
import '../remote_data_source/auth_remote_data_source.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepoImpl(this.authRemoteDataSource);

  @override
  Future<Either<FailureService, GoogleUserModel>> signInWithGoogle() async {
    try {
      final user = await authRemoteDataSource.signInWithGoogle();

      await HiveStorage.saveGoogleUser(user);

      return Right(user);
    } catch (e) {
      return Left(ServiceFailure(e.toString()));
    }
  }

  @override
  Future<Either<FailureService, GoogleUserModel>> signInWithFacebook() async {
    try {
      final user = await authRemoteDataSource.signInWithFacebook();
      return Right(user);
    } catch (e) {
      return Left(ServiceFailure(e.toString()));
    }
  }

  @override
  Future<Either<FailureService, String>> checkUserExists(
      String userId, String password) async {
    try {
      final result =
          await authRemoteDataSource.checkUserExists(userId, password);
      return Right(result);
    } catch (e) {
      return Left(ServiceFailure(e.toString()));
    }
  }

  @override
  Future<void> checkUserExistsR(String phone) async {
    try {
      await authRemoteDataSource.checkUserExistsR(phone);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> saveUser({
    required UserModel userModel,
  }) async {
    try {
      await authRemoteDataSource.saveUserToFireStore(userModel: userModel);
      await HiveStorage.saveDefaultUser(userModel);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> sendOtp(String phoneNumber, Function(String) onCodeSent) async {
    try {
      await authRemoteDataSource.signInWithPhoneNumber(phoneNumber, onCodeSent);
    } catch (e) {
      rethrow;
    }
  }
}
