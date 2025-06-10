import 'package:dartz/dartz.dart';
import 'package:yourseatgraduationproject/features/admin_flow/payment/data/model/transaction_model.dart';
import '../../../../../services/failure_service.dart';

abstract class PaymentRepo {
  Future<Either<FailureService, String?>> payWithPayMob(num amount);
  Future<Either<FailureService, String?>> getAuthToken();
  Map<String, int> getTransactionStats();
  void resetTransactionStats();

  Future<Either<FailureService, int>> getOrderId(
      {required String token, required String amount});

  Future<Either<FailureService, String>> getPaymentKey(
      {required String token, required int orderId, required String amount});

  Future<Either<FailureService, void>> refundPayment(
      {required String transactionId, required int amount});

  Future<Either<FailureService, List<TransactionModel>>> getAllTransactions(
      {int limit = 10, int page = 1});
}
