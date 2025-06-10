part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

// Google Authentication States
final class GoogleAuthLoading extends AuthState {}

final class GoogleAuthSuccess extends AuthState {
  final GoogleUserModel user;
  GoogleAuthSuccess(this.user);
}

final class GoogleAuthError extends AuthState {
  final String errorMsg;
  GoogleAuthError(this.errorMsg);
}

// Facebook Authentication States
final class FacebookAuthLoading extends AuthState {}

final class FacebookAuthSuccess extends AuthState {
  final GoogleUserModel user;
  FacebookAuthSuccess(this.user);
}

final class FacebookAuthError extends AuthState {
  final String errorMsg;
  FacebookAuthError(this.errorMsg);
}

// User Validation States (Check User Exists)
final class UserValidationLoading extends AuthState {}

final class UserValidationSuccess extends AuthState {
  final String message;
  UserValidationSuccess(this.message);
}

final class UserValidationError extends AuthState {
  final String error;
  UserValidationError(this.error);
}

class OtpSent extends AuthState {
  final String verificationId;

  OtpSent(this.verificationId);

  List<Object?> get props => [verificationId];
}

// State for successful registration
class AuthSuccess extends AuthState {}

// State for any error that occurs
class AuthError extends AuthState {
  final String errorMessage;

  AuthError(this.errorMessage);

  List<Object?> get props => [errorMessage];
}

final class UpdatePasswordLoading extends AuthState {}

final class UpdatePasswordSuccess extends AuthState {}

final class UpdatePasswordError extends AuthState {
  final String errorMessage;

  UpdatePasswordError(this.errorMessage);
}
