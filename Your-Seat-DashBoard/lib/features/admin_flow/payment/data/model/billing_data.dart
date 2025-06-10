import 'package:equatable/equatable.dart';

class BillingData extends Equatable {
  final String firstName;
  final String lastName;
  final String email;
  final num transactionId;

  const BillingData({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.transactionId,
  });

  factory BillingData.fromJson(Map<String, dynamic> json) {
    return BillingData(
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      transactionId: json['transaction_id'],
    );
  }

  @override
  List<Object?> get props => [firstName, lastName, email, transactionId];
}
