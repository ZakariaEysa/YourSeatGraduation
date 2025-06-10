import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourseatgraduationproject/features/user_flow/payment/domain/repos/payment_repo.dart';
import 'package:yourseatgraduationproject/utils/app_logs.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  final PaymentRepo paymentRepo;

  String orderIdForPaymentTicket = "";
  PaymentCubit(this.paymentRepo) : super(PaymentInitial());
  static PaymentCubit get(context) => BlocProvider.of<PaymentCubit>(context);

  Future<void> getAllTransactions({int limit = 10, int page = 1}) async {
    emit(TransactionLoading());
    final result =
        await paymentRepo.getAllTransactions(limit: limit, page: page);
    result.fold(
      (failure) => emit(TransactionError(failure.errorMsg)),
      (transactions) => emit(TransactionSuccess(transactions)),
    );
  }

  Future<void> payWithPayMobToGetOrderId(num amount) async {
    emit(PaymentLoading());

    final authResult = await paymentRepo.getAuthToken();
    final token = authResult.fold(
      (failure) {
        emit(PaymentError(failure.errorMsg));
        return null;
      },
      (token) => token,
    );

    if (token == null) return;

    final orderResult = await paymentRepo.getOrderId(
      token: token,
      amount: (100 * amount).toString(),
    );

    final orderId = orderResult.fold(
      (failure) {
        emit(PaymentError(failure.errorMsg));
        return null;
      },
      (id) => id.toString(), // الاحتفاظ به كنص
    );

    if (orderId == null) return;

    orderIdForPaymentTicket = orderId;

    final paymentKeyResult = await paymentRepo.getPaymentKey(
      token: token,
      orderId: int.parse(orderId), // تحويل إلى int عند الحاجة
      amount: (100 * amount).toString(),
    );

    paymentKeyResult.fold(
      (failure) => emit(PaymentError(failure.errorMsg)),
      (payToken) => emit(PaymentSuccess(payToken)),
    );
  }

  Future<void> payWithPayMob(num amount) async {
    emit(PaymentLoading());

    final result = await paymentRepo.payWithPayMob(amount);

    result.fold(
      (failure) => emit(PaymentError(failure.errorMsg)),
      (payToken) => emit(PaymentSuccess(payToken)),
    );
  }

  Future<void> refundPayment(
      {required String transactionId, required int amount}) async {
    emit(RefundLoading());
    final result = await paymentRepo.refundPayment(
        transactionId: transactionId, amount: amount);
    result.fold(
      (failure) => emit(RefundError(failure.errorMsg)),
      (_) => emit(RefundSuccess()),
    );
  }

  Future<void> getAuthToken() async {
    emit(AuthLoading());
    final result = await paymentRepo.getAuthToken();
    result.fold(
      (failure) => emit(AuthError(failure.errorMsg)),
      (token) => emit(AuthSuccess(token)),
    );
  }

  Future<void> getOrderId(
      {required String token, required String amount}) async {
    emit(OrderLoading());
    final result = await paymentRepo.getOrderId(token: token, amount: amount);
    result.fold(
      (failure) => emit(OrderError(failure.errorMsg)),
      (orderId) => emit(OrderSuccess(orderId)),
    );
  }

  Future<void> getPaymentKey(
      {required String token,
      required int orderId,
      required String amount}) async {
    emit(PaymentKeyLoading());
    final result = await paymentRepo.getPaymentKey(
        token: token, orderId: orderId, amount: amount);
    result.fold(
      (failure) => emit(PaymentKeyError(failure.errorMsg)),
      (paymentKey) => emit(PaymentKeySuccess(paymentKey)),
    );
  }
}
