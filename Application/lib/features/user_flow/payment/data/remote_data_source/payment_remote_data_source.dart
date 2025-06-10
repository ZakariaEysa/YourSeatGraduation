import 'dart:async';

import 'package:dio/dio.dart';

import '../../../../../core/Network/end_points.dart';

import '../../../../../../data/hive_keys.dart';
import '../../../../../data/hive_storage.dart';

abstract class PaymentRemoteDataSource {
  Future<String?> payWithPayMob(num amount);
  Future<String?> getAuthToken();

  Future<int> getOrderId({required String token, required String amount});

  Future<String> getPaymentKey(
      {required String token, required int orderId, required String amount});

  Future<void> refundPayment(
      {required String transactionId, required int amount});

  Future<List<dynamic>> getAllTransactions({int limit = 10, int page = 1});
}

class PaymentRemoteDataSourceImpl implements PaymentRemoteDataSource {
  PaymentRemoteDataSourceImpl();
  Dio dio = Dio(BaseOptions(
    validateStatus: (status) => true, // يقبل أي status code
  ));
  @override
  Future<String?> payWithPayMob(num amount) async {
    try {
      final token = await getAuthToken();
      // AppLogs.errorLog("token : $token"); // Removed: was used for logging token
      final orderId =
          await getOrderId(token: token!, amount: (100 * amount).toString());

      final paymentKey = await getPaymentKey(
          token: token, orderId: orderId, amount: (100 * amount).toString());
      // AppLogs.successLog(paymentKey.toString()); // Removed: was used for logging payment key
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
      // AppLogs.errorLog(response.data.toString()); // Removed: was used for logging response data
      // AppLogs.debugLog(response.statusCode.toString()); // Removed: was used for logging status code
      // AppLogs.successLog(response.data["token"].toString()); // Removed: was used for logging token

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
      // AppLogs.debugLog(response.data.toString());
      // AppLogs.debugLog(response.statusCode.toString());

      // AppLogs.successLog(response.data["id"].toString());

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

      if (HiveStorage.get(HiveKeys.role) == Role.google.toString()) {
        currentUser = HiveStorage.getGoogleUser();
      } else {
        currentUser = HiveStorage.getDefaultUser();
      }
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
      // AppLogs.infoLog(response.data.toString()); // Removed: was used for logging response data
      // AppLogs.debugLog(response.statusCode.toString()); // Removed: was used for logging status code

      return response.data["token"];
    } catch (e) {
      // AppLogs.errorLog(e.toString()); // Removed: was used for logging error
      rethrow;
    }
  }

  @override
  Future<void> refundPayment(
      {required String transactionId, required int amount}) async {
    try {
      final token = await getAuthToken();

      // AppLogs.errorLog(token.toString()); // Removed: was used for logging token

      final response = await dio.post(
        "https://accept.paymob.com/api/acceptance/void_refund/refund",
        data: {
          "auth_token": token,
          "transaction_id": transactionId,
          "amount_cents": 100 * amount,
        },
      );

      // AppLogs.errorLog(response.data.toString());
      // if (response.statusCode != 200 && response.statusCode != 201) {
      //   AppLogs.errorLog(response.data["message"].toString()); // Removed: was used for logging error message
      // }
      // AppLogs.errorLog(response.data.toString()); // Removed: was used for logging response data
      // AppLogs.errorLog(response.data["message"].toString()); // Removed: was used for logging error message
      // if (response.statusCode == 200 && response.data["success"] == true) {
      //   AppLogs.successLog("Refund successful for transaction $transactionId"); // Removed: was used for logging refund success
      // } else {
      //   AppLogs.errorLog("Refund failed: response.data"); // Removed: was used for logging refund failure
      // }
    } catch (e) {
      // AppLogs.errorLog("Refund request failed: e.toString()"); // Removed: was used for logging refund request failure
    }
  }

  @override
  Future<List<dynamic>> getAllTransactions(
      {int limit = 10, int page = 1}) async {
    try {
      final token = await getAuthToken(); // جلب التوكن

      final response = await dio.get(
        "https://accept.paymob.com/api/acceptance/transactions",
        queryParameters: {
          "page": page, // تحديد رقم الصفحة
          "limit": limit, // عدد النتائج في كل صفحة
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          },
        ),
      );
      // AppLogs.successLog("Transactions: 4response.data["results"].length4"); // Removed: was used for logging transactions count
      // AppLogs.successLog("Transactions: 4response.data["results"][0]4"); // Removed: was used for logging first transaction
      // AppLogs.successLog("Transactions: 4response.data["results"].length4"); // Removed: was used for logging transactions count (duplicate)
      // AppLogs.errorLog("Error fetching transactions: 4response.data4"); // Removed: was used for logging error fetching transactions

      if (response.statusCode == 200) {
        return response.data["results"] ?? []; // إرجاع المعاملات
      } else {
        return [];
      }
    } catch (e) {
      // AppLogs.errorLog("Failed to fetch transactions: e.toString()"); // Removed: was used for logging failed fetch transactions
      return [];
    }
  }
}
