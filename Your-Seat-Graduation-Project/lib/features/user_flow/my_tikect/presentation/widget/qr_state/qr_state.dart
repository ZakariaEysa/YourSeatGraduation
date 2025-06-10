// import 'package:equatable/equatable.dart';
//
// class QrState extends Equatable {
//   final String orderId;
//   final String movieName;
//   final String movieDuration;
//   final String movieCategory;
//   final String seatCategory;
//   final String movieTime;
//   final String movieDate;
//   final List<String> seats;
//   final String hall;
//   final String cost;
//   final String cinemaId;
//   final String location;
//   final String status;
//   final bool isLoading;
//   final String? filePath;
//   final String? errorMessage;
//
//   const QrState({
//     required this.orderId,
//     required this.movieName,
//     required this.movieDuration,
//     required this.movieCategory,
//     required this.seatCategory,
//     required this.movieTime,
//     required this.movieDate,
//     required this.seats,
//     required this.hall,
//     required this.cost,
//     required this.cinemaId,
//     required this.location,
//     required this.status,
//     this.isLoading = false,
//     this.filePath,
//     this.errorMessage,
//   });
//
//   QrState copyWith({
//     bool? isLoading,
//     String? filePath,
//     String? errorMessage,
//   }) {
//     return QrState(
//       orderId: orderId,
//       movieName: movieName,
//       movieDuration: movieDuration,
//       movieCategory: movieCategory,
//       seatCategory: seatCategory,
//       movieTime: movieTime,
//       movieDate: movieDate,
//       seats: seats,
//       hall: hall,
//       cost: cost,
//       cinemaId: cinemaId,
//       location: location,
//       status: status,
//       isLoading: isLoading ?? this.isLoading,
//       filePath: filePath,
//       errorMessage: errorMessage,
//     );
//   }
//
//   @override
//   List<Object?> get props => [
//     orderId,
//     movieName,
//     movieDuration,
//     movieCategory,
//     seatCategory,
//     movieTime,
//     movieDate,
//     seats,
//     hall,
//     cost,
//     cinemaId,
//     location,
//     status,
//     isLoading,
//     filePath,
//     errorMessage,
//   ];
// }
