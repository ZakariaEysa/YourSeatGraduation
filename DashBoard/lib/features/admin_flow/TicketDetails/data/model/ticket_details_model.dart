import 'package:equatable/equatable.dart';

class Ticket extends Equatable {
  final String orderId;
  final String posterImage;
  final num totalPrice;
  final String time;
  final String seatCategory;
  final String category;
  final List<String> seats;
  final String date;
  final String hall;
  final String status;
  final String userEmail;
  final String duration;
  final String movieName;

  const Ticket({
    required this.orderId,
    required this.posterImage,
    required this.totalPrice,
    required this.time,
    required this.seatCategory,
    required this.category,
    required this.seats,
    required this.date,
    required this.hall,
    required this.status,
    required this.userEmail,
    required this.duration,
    required this.movieName,
  });

  factory Ticket.fromMap(Map<String, dynamic> map) {
    return Ticket(
      orderId: map['orderId'].toString(),
      posterImage: map['poster_image'] ?? '',
      totalPrice: map['totalPrice'] ?? 0,
      time: map['time'] ?? '',
      seatCategory: map['seatCategory'] ?? '',
      category: map['category'] ?? '',
      seats: List<String>.from(map['seats'] ?? []),
      date: map['date'] ?? '',
      hall: map['hall'] ?? '',
      status: map['status'] ?? '',
      userEmail: map['userEmail'] ?? '',
      duration: map['duration'] ?? '',
      movieName: map['movieName'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'poster_image': posterImage,
      'totalPrice': totalPrice,
      'time': time,
      'seatCategory': seatCategory,
      'category': category,
      'seats': seats,
      'date': date,
      'hall': hall,
      'status': status,
      'userEmail': userEmail,
      'duration': duration,
      'movieName': movieName,
    };
  }

  @override
  List<Object?> get props => [
        orderId,
        posterImage,
        totalPrice,
        time,
        seatCategory,
        category,
        seats,
        date,
        hall,
        status,
        userEmail,
        duration,
        movieName,
      ];
}
