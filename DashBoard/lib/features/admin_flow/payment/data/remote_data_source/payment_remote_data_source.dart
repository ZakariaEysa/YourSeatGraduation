import 'dart:async';

import 'package:dio/dio.dart';

import 'package:yourseatgraduationproject/core/Network/end_points.dart';
import 'package:yourseatgraduationproject/features/admin_flow/payment/data/model/transaction_model.dart';

import '../../../../../utils/app_logs.dart';

abstract class PaymentRemoteDataSource {
  Future<String?> payWithPayMob(num amount);
  Future<String?> getAuthToken();
  Map<String, int> getTransactionStats();
  void resetTransactionStats();
  Future<int> getOrderId({required String token, required String amount});

  Future<String> getPaymentKey(
      {required String token, required int orderId, required String amount});

  Future<void> refundPayment(
      {required String transactionId, required int amount});

  Future<List<TransactionModel>> getAllTransactions(
      {int limit = 10, int page = 1});
}

class PaymentRemoteDataSourceImpl implements PaymentRemoteDataSource {
  PaymentRemoteDataSourceImpl();
  int total = 0;
  int completed = 0;
  int refunded = 0;
  int transactionPage = 1;

  Dio dio = Dio(BaseOptions(
    validateStatus: (status) => true, // يقبل أي status code
  ));
  @override
  Future<String?> payWithPayMob(num amount) async {
    try {
      final token = await getAuthToken();
      AppLogs.errorLog("token : $token");
      final orderId =
          await getOrderId(token: token!, amount: (100 * amount).toString());

      final paymentKey = await getPaymentKey(
          token: token, orderId: orderId, amount: (100 * amount).toString());
      AppLogs.scussessLog(paymentKey.toString());
      return paymentKey;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String?> getAuthToken() async {
    try {
      final response = await dio.post(
        "https://accept.paymob.com/api/auth/tokens",

        // headers: {"Content-Type": "application/json"},
        data: {"api_key": EndPoints.api_key},
      );
      AppLogs.errorLog(response.data.toString());
      AppLogs.debugLog(response.statusCode.toString());
      AppLogs.scussessLog(response.data["token"].toString());

      return response.data["token"];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<int> getOrderId(
      {required String token, required String amount}) async {
    try {
      final response = await dio
          .post("https://accept.paymob.com/api/ecommerce/orders", data: {
        "auth_token": token,
        "delivery_needed": "true",
        "amount_cents": amount,
        "currency": "EGP",
        "items": [],
      });
      AppLogs.debugLog(response.data.toString());
      AppLogs.debugLog(response.statusCode.toString());

      AppLogs.scussessLog(response.data["id"].toString());

      return response.data["id"];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> getPaymentKey(
      {required String token,
      required int orderId,
      required String amount}) async {
    try {
      var currentUser;

      // if (HiveStorage.get(HiveKeys.role) == Role.google.toString()) {
      //   currentUser = HiveStorage.getGoogleUser();
      // } else {
      //   currentUser = HiveStorage.getDefaultUser();
      // }
      //4979915 vc
      //visa 4979914

      final response = await dio
          .post("https://accept.paymob.com/api/acceptance/payment_keys", data: {
        "auth_token": token,
        "amount_cents": amount,
        "currency": "EGP",
        "integration_id": 4979914,
        "order_id": orderId,
        "lock_order_when_paid": "false",
        "billing_data": {
          "apartment": "NA",
          "email": currentUser.email ?? "zakariaeysa@gmail.com",
          "floor": "NA",
          "first_name": currentUser.name ?? "ziko",
          "street": "NA",
          "building": "NA",
          "phone_number": "NA",
          "shipping_method": "NA",
          "city": "NA",
          "country": "NA",
          "postal_code": "NA",
          "last_name": currentUser.name ?? "ziko",
          "state": "NA"
        }
      });
      AppLogs.infoLog(response.data.toString());
      AppLogs.debugLog(response.statusCode.toString());

      return response.data["token"];
    } catch (e) {
      AppLogs.errorLog(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> refundPayment(
      {required String transactionId, required int amount}) async {
    try {
      final token = await getAuthToken();

      AppLogs.errorLog(token.toString());

      final response = await dio.post(
        "https://accept.paymob.com/api/acceptance/void_refund/refund",
        data: {
          "auth_token": token,
          "transaction_id": transactionId,
          "amount_cents": 100 * amount,
        },
      );

      AppLogs.errorLog(response.data.toString());
      if (response.statusCode != 200 && response.statusCode != 201) {
        AppLogs.errorLog(response.data["message"].toString());
      }
      // if (response.statusCode == 200 && response.data["success"] == true) {
      //   AppLogs.scussessLog("Refund successful for transaction $transactionId");
      // } else {
      //   AppLogs.errorLog("Refund failed: ${response.data}");
      // }
    } catch (e) {
      AppLogs.errorLog("Refund request failed: ${e.toString()}");
    }
  }

  @override
  Future<List<TransactionModel>> getAllTransactions(
      {int limit = 10, int page = 1}) async {
    List<TransactionModel> allTransactions = [];

    int limit = 0;
    bool hasMore = true;

    try {
      final token = await getAuthToken(); // جلب التوكن

      // while (hasMore) {
      final response = await dio.get(
        "https://accept.paymob.com/api/acceptance/transactions",
        queryParameters: {
          "page": transactionPage,
          "limit": limit,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        final results = response.data["results"] as List;
        AppLogs.scussessLog(
            "Page $transactionPage - Fetched ${results.length} transactions");

        if (results.isEmpty) {
          hasMore = false;
        } else {
          final transactions =
              results.map((item) => TransactionModel.fromJson(item)).toList();

          for (var tx in transactions) {
            if (tx.success == true) completed++;
            if (tx.isRefund == true || tx.isRefunded == true) refunded++;
          }

          allTransactions.addAll(transactions);
          AppLogs.errorLog(results.length.toString());
          AppLogs.errorLog(limit.toString());
          // if (page > limit) {
          //   hasMore = false;
          // } else {
          //   page++;
          // }
          transactionPage++;
        }
      } else {
        AppLogs.errorLog("Error fetching transactions: ${response.data}");
        hasMore = false;
      }
      // }

      AppLogs.scussessLog(
          "✅ Total transactions fetched: ${allTransactions.length}");
      AppLogs.scussessLog("✔️ Successful transactions: $completed");
      AppLogs.scussessLog("↩️ Refunded transactions: $refunded");

      total += allTransactions.length;
    } catch (e) {
      AppLogs.errorLog("❌ Failed to fetch transactions: ${e.toString()}");
    }

    return allTransactions;
  }

  @override
  Map<String, int> getTransactionStats() {
    return {"total": total, "completed": completed, "refunded": refunded};
  }

  @override
  void resetTransactionStats() {
    total = 0;
    completed = 0;
    refunded = 0;
  }
}
