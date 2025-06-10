part of 'payment_cubit.dart';

sealed class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object> get props => [];
}

final class PaymentInitial extends PaymentState {}

final class PaymentLoading extends PaymentState {}

final class PaymentSuccess extends PaymentState {
  final String? payToken;
  const PaymentSuccess(this.payToken);
}

final class PaymentError extends PaymentState {
  final String error;
  const PaymentError(this.error);
}

final class TransactionLoading extends PaymentState {}

final class TransactionSuccess extends PaymentState {
  const TransactionSuccess();
}

final class TransactionError extends PaymentState {
  final String error;
  const TransactionError(this.error);
}

// حالات الاستيت
final class RefundLoading extends PaymentState {}

final class RefundSuccess extends PaymentState {}

final class RefundError extends PaymentState {
  final String error;
  const RefundError(this.error);
}

final class AuthLoading extends PaymentState {}

final class AuthSuccess extends PaymentState {
  final String? token;
  const AuthSuccess(this.token);
}

final class AuthError extends PaymentState {
  final String error;
  const AuthError(this.error);
}

final class OrderLoading extends PaymentState {}

final class OrderSuccess extends PaymentState {
  final int orderId;
  const OrderSuccess(this.orderId);
}

final class OrderError extends PaymentState {
  final String error;
  const OrderError(this.error);
}

final class PaymentKeyLoading extends PaymentState {}

final class PaymentKeySuccess extends PaymentState {
  final String paymentKey;
  const PaymentKeySuccess(this.paymentKey);
}

final class PaymentKeyError extends PaymentState {
  final String error;
  const PaymentKeyError(this.error);
}
