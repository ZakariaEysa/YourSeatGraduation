import 'package:equatable/equatable.dart';
import 'package:yourseatgraduationproject/features/admin_flow/payment/data/model/order.dart';

import 'billing_data.dart';

class TransactionModel extends Equatable {
  final num id;
  final bool pending;
  final num amountCents;
  final bool success;
  final bool isAuth;
  final bool isCapture;
  final bool isStandalonePayment;
  final bool isVoided;
  final bool isRefunded;
  final bool is3dSecure;
  final num integrationId;
  final Order? order;
  final String currency;
  final bool isCashout;
  final bool isUpg;
  final bool isInternalRefund;
  final BillingData? billingData;
  final String? cardType;
  final num originalAmount;
  final String paymentSource;
  final bool isVoid;
  final bool isRefund;
  final bool isHidden;
  final bool errorOccurred;
  final bool isLive;
  final bool isCaptured;
  final num capturedAmount;
  final num refundedAmountCents;
  final DateTime? updatedAt;
  final String date;
  final String status;

  const TransactionModel({
    required this.status,
    required this.date,
    required this.id,
    required this.pending,
    required this.amountCents,
    required this.success,
    required this.isAuth,
    required this.isCapture,
    required this.isStandalonePayment,
    required this.isVoided,
    required this.isRefunded,
    required this.is3dSecure,
    required this.integrationId,
    required this.order,
    required this.currency,
    required this.isCashout,
    required this.isUpg,
    required this.isInternalRefund,
    required this.billingData,
    required this.cardType,
    required this.originalAmount,
    required this.paymentSource,
    required this.isVoid,
    required this.isRefund,
    required this.isHidden,
    required this.errorOccurred,
    required this.isLive,
    required this.isCaptured,
    required this.capturedAmount,
    required this.refundedAmountCents,
    required this.updatedAt,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      date: json['created_at'] ?? 0,
      status: json['is_refunded'] == true
          ? 'Refund'
          : json['success'] == true
              ? 'Complete'
              : 'Rejected',
      id: json['id'] ?? "",
      pending: json['pending'],
      amountCents: json['amount_cents'],
      success: json['success'],
      isAuth: json['is_auth'],
      isCapture: json['is_capture'],
      isStandalonePayment: json['is_standalone_payment'],
      isVoided: json['is_voided'],
      isRefunded: json['is_refunded'],
      is3dSecure: json['is_3d_secure'],
      integrationId: json['integration_id'],
      order: json['order'] != null ? Order.fromJson(json['order']) : null,
      currency: json['currency'],
      isCashout: json['is_cashout'],
      isUpg: json['is_upg'],
      isInternalRefund: json['is_internal_refund'],
      billingData: json['billing_data'] != null
          ? BillingData.fromJson(json['billing_data'])
          : null,
      cardType: json['card_type'],
      originalAmount: json['original_amount'],
      paymentSource: json['payment_source'],
      isVoid: json['is_void'],
      isRefund: json['is_refund'],
      isHidden: json['is_hidden'],
      errorOccurred: json['error_occured'],
      isLive: json['is_live'],
      isCaptured: json['is_captured'],
      capturedAmount: json['captured_amount'],
      refundedAmountCents: json['refunded_amount_cents'],
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  @override
  List<Object?> get props => [
        date,
        status,
        id,
        pending,
        amountCents,
        success,
        isAuth,
        isCapture,
        isStandalonePayment,
        isVoided,
        isRefunded,
        is3dSecure,
        integrationId,
        order,
        currency,
        isCashout,
        isUpg,
        isInternalRefund,
        billingData,
        cardType,
        originalAmount,
        paymentSource,
        isVoid,
        isRefund,
        isHidden,
        errorOccurred,
        isLive,
        isCaptured,
        capturedAmount,
        refundedAmountCents,
        updatedAt,
      ];
}
