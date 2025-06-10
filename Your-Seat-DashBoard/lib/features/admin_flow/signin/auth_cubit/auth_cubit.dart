import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourseatgraduationproject/core/contants/errors.dart';

import '../../../../data/local_storage_service/local_storage_service.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> signIn(String email, String password) async {
    emit(AuthLoading());
    try {
      if (email.isEmpty || password.isEmpty) {
        emit(AuthFailure(Errors.pleaseFillInAllFields));
        return;
      }

      final emailRegex = RegExp(r'^[\w-\.]+@admin\.com$');
      if (!emailRegex.hasMatch(email)) {
        emit(AuthFailure(Errors.emailMustBeAValidAdminEmail));
        return;
      }

      if (password.length < 8) {
        emit(AuthFailure(Errors.passwordMustBeAtLeast8Characters));
        return;
      }

      final adminUsersRef =
          FirebaseFirestore.instance.collection('admin_users');
      final querySnapshot =
          await adminUsersRef.where('email', isEqualTo: email).get();

      if (querySnapshot.docs.isEmpty) {
        emit(AuthFailure(Errors.emailNotFound));
        return;
      }

      final docData = querySnapshot.docs.first.data();

      if (docData['password'] == password) {
        LocalStorageService.saveUserData(email);
        emit(AuthSuccess());
      } else {
        emit(AuthFailure(Errors.incorrectPassword));
      }
    } catch (e) {
      emit(AuthFailure('An error occurred: $e'));
    }
  }
}
