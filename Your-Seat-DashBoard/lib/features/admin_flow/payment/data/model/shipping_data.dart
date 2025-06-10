import 'package:equatable/equatable.dart';

class ShippingData extends Equatable {
  final num id;
  final String firstName;
  final String lastName;
  final String email;
  final num orderId;

  const ShippingData({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.orderId,
  });

  factory ShippingData.fromJson(Map<String, dynamic> json) {
    return ShippingData(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      orderId: json['order_id'],
    );
  }

  @override
  List<Object?> get props => [id, firstName, lastName, email, orderId];
}
