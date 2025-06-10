import 'package:equatable/equatable.dart';

class TicketModel extends Equatable {
  final String date;
  final String duration;
  final String orderId;
  final String hall;
  final String posterImage;
  final num totalPrice;
  final String status;
  final String category;
  final String seatCategory;
  final String movieName;
  final String time;
  final String userEmail;
  final List<String> seats;

  const TicketModel({
    required this.date,
    required this.duration,
    required this.orderId,
    required this.hall,
    required this.posterImage,
    required this.totalPrice,
    required this.status,
    required this.category,
    required this.seatCategory,
    required this.movieName,
    required this.time,
    required this.userEmail,
    required this.seats,
  });

  factory TicketModel.fromMap(Map<String, dynamic> map) {
    return TicketModel(
      date: map['date'] ?? '',
      duration: map['duration'] ?? '',
      orderId: map['orderId'] ?? "",
      hall: map['hall'] ?? '',
      posterImage: map['poster_image'] ?? '',
      totalPrice: map['totalPrice'] ?? 0,
      status: map['status'] ?? '',
      category: map['category'] ?? '',
      seatCategory: map['seatCategory'] ?? '',
      movieName: map['movieName'] ?? '',
      time: map['time'] ?? '',
      userEmail: map['userEmail'] ?? '',
      seats: List<String>.from(map['seats'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'duration': duration,
      'orderId': orderId,
      'hall': hall,
      'poster_image': posterImage,
      'totalPrice': totalPrice,
      'status': status,
      'category': category,
      'seatCategory': seatCategory,
      'movieName': movieName,
      'time': time,
      'userEmail': userEmail,
      'seats': seats,
    };
  }

  @override
  List<Object?> get props => [
        date,
        duration,
        orderId,
        hall,
        posterImage,
        totalPrice,
        status,
        category,
        seatCategory,
        movieName,
        time,
        userEmail,
        seats,
      ];
}
