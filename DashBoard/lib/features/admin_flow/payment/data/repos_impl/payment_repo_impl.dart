import 'package:dartz/dartz.dart';
import 'package:yourseatgraduationproject/features/admin_flow/payment/data/model/transaction_model.dart';
import '../../../../../services/failure_service.dart';
import '../../domain/repos/payment_repo.dart';
import '../remote_data_source/payment_remote_data_source.dart';

class PaymentRepoImpl implements PaymentRepo {
  final PaymentRemoteDataSource paymentRemoteDataSource;

  PaymentRepoImpl(this.paymentRemoteDataSource);

  @override
  Map<String, int> getTransactionStats() =>
      paymentRemoteDataSource.getTransactionStats();
  @override
  Future<Either<FailureService, List<TransactionModel>>> getAllTransactions(
      {int limit = 10, int page = 1}) async {
    try {
      final transactions = await paymentRemoteDataSource.getAllTransactions(
          limit: limit, page: page);

      return Right(transactions);
    } catch (e) {
      return Left(ServiceFailure(e.toString()));
    }
  }

  @override
  Future<Either<FailureService, String?>> getAuthToken() async {
    try {
      final authToken = await paymentRemoteDataSource.getAuthToken();

      return Right(authToken);
    } catch (e) {
      return Left(ServiceFailure(e.toString()));
    }
  }

  @override
  Future<Either<FailureService, int>> getOrderId(
      {required String token, required String amount}) async {
    try {
      final orderId = await paymentRemoteDataSource.getOrderId(
          token: token, amount: amount);

      return Right(orderId);
    } catch (e) {
      return Left(ServiceFailure(e.toString()));
    }
  }

  @override
  Future<Either<FailureService, String>> getPaymentKey(
      {required String token,
      required int orderId,
      required String amount}) async {
    try {
      final paymentKey = await paymentRemoteDataSource.getPaymentKey(
          token: token, orderId: orderId, amount: amount);

      return Right(paymentKey);
    } catch (e) {
      return Left(ServiceFailure(e.toString()));
    }
  }

  @override
  Future<Either<FailureService, String?>> payWithPayMob(num amount) async {
    try {
      final paymentToken = await paymentRemoteDataSource.payWithPayMob(amount);

      return Right(paymentToken);
    } catch (e) {
      return Left(ServiceFailure(e.toString()));
    }
  }

  @override
  Future<Either<FailureService, void>> refundPayment(
      {required String transactionId, required int amount}) async {
    try {
      final refundStatus = await paymentRemoteDataSource.refundPayment(
          transactionId: transactionId, amount: amount);

      return Right(refundStatus);
    } catch (e) {
      return Left(ServiceFailure(e.toString()));
    }
  }

  @override
  void resetTransactionStats() {
    paymentRemoteDataSource.resetTransactionStats();
  }
}
