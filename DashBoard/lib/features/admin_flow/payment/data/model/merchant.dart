import 'package:equatable/equatable.dart';

class Merchant extends Equatable {
  final num id;
  final DateTime createdAt;
  final List<String> phones;
  final List<String> companyEmails;
  final String companyName;
  final String? city;
  final String? country;

  const Merchant({
    required this.id,
    required this.createdAt,
    required this.phones,
    required this.companyEmails,
    required this.companyName,
    this.city,
    this.country,
  });

  factory Merchant.fromJson(Map<String, dynamic> json) {
    return Merchant(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      phones: List<String>.from(json['phones'] ?? []),
      companyEmails: List<String>.from(json['company_emails'] ?? []),
      companyName: json['company_name'],
      city: json['city'],
      country: json['country'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        createdAt,
        phones,
        companyEmails,
        companyName,
        city,
        country,
      ];
}
