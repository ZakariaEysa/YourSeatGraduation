import 'package:equatable/equatable.dart';
import 'package:yourseatgraduationproject/features/admin_flow/payment/data/model/merchant.dart';
import 'package:yourseatgraduationproject/features/admin_flow/payment/data/model/shipping_data.dart';

class Order extends Equatable {
  final num id;
  final DateTime createdAt;
  final bool deliveryNeeded;
  final Merchant merchant;
  final num amountCents;
  final ShippingData shippingData;
  final num paidAmountCents;
  final String paymentStatus;
  final String orderUrl;

  const Order({
    required this.id,
    required this.createdAt,
    required this.deliveryNeeded,
    required this.merchant,
    required this.amountCents,
    required this.shippingData,
    required this.paidAmountCents,
    required this.paymentStatus,
    required this.orderUrl,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      deliveryNeeded: json['delivery_needed'],
      merchant: Merchant.fromJson(json['merchant']),
      amountCents: json['amount_cents'],
      shippingData: ShippingData.fromJson(json['shipping_data']),
      paidAmountCents: json['paid_amount_cents'],
      paymentStatus: json['payment_status'],
      orderUrl: json['order_url'] ?? '',
    );
  }

  @override
  List<Object?> get props => [
        id,
        createdAt,
        deliveryNeeded,
        merchant,
        amountCents,
        shippingData,
        paidAmountCents,
        paymentStatus,
        orderUrl,
      ];
}
