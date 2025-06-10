// sign_in_logic.dart
import 'package:flutter/material.dart';
import '../../../../../utils/dialog_utilits.dart';
import '../../../../../utils/navigation.dart';
import '../../../home/presentation/views/home_layout.dart';
import '../../data/model/user_model.dart';
import '../../../../../data/hive_keys.dart';
import '../../../../../data/hive_storage.dart';
import '../cubit/auth_cubit.dart';
import '../../../../../generated/l10n.dart';

class SignInLogic {
  static void handleAuthState(BuildContext context, AuthState state) {
    final lang = S.of(context);

    if (state is GoogleAuthSuccess) {
      HiveStorage.set(HiveKeys.role, Role.google.toString());
      showCenteredSnackBar(
          context, '${lang.login_successful} ${state.user.name}');
      navigateAndRemoveUntil(context: context, screen: const HomeLayout());
    } else if (state is FacebookAuthSuccess) {
      HiveStorage.set(HiveKeys.role, Role.facebook.toString());
      showCenteredSnackBar(
          context, '${lang.login_successful} ${state.user.name}');
      navigateAndRemoveUntil(context: context, screen: const HomeLayout());
    } else if (state is UserValidationSuccess) {
      HiveStorage.set(HiveKeys.role, Role.email.toString());
      showCenteredSnackBar(context, lang.login_successful);
      navigateAndRemoveUntil(context: context, screen: const HomeLayout());
    } else if (state is GoogleAuthError ||
        state is FacebookAuthError ||
        state is UserValidationError) {
      final error = state is GoogleAuthError
          ? state.errorMsg
          : state is FacebookAuthError
              ? state.errorMsg
              : (state as UserValidationError).error;
      showCenteredSnackBar(context, error);
    }
  }

  static void handleLoginButtonTap(BuildContext context, AuthCubit cubit) {
    final lang = S.of(context);
    if (cubit.formKeyLogin.currentState!.validate()) {
      cubit.validateUser(
        cubit.emailController.text,
        cubit.passwordController.text,
      );
    } else {
      showCenteredSnackBar(context, lang.fill_all_fields);
    }
  }

  static void loginAsGuest(BuildContext context) {
    HiveStorage.saveDefaultUser(UserModel(
      name: "guest",
      email: '-',
      password: '-',
      dateOfBirth: '-',
      image: '',
    ));
    HiveStorage.set(HiveKeys.role, Role.guest.toString());
    navigateAndRemoveUntil(context: context, screen: const HomeLayout());
  }
}
