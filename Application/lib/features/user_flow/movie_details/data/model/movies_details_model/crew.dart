import 'package:equatable/equatable.dart';

class Crew extends Equatable {
  final String? director;
  final String? producer;
  final String? writer;

  const Crew({this.director, this.producer, this.writer});

  factory Crew.fromJson(Map<String, dynamic> json) => Crew(
        director: json['director'] as String?,
        producer: json['producer'] as String?,
        writer: json['writer'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'director': director,
        'producer': producer,
        'writer': writer,
      };

  @override
  List<Object?> get props => [director, producer, writer];
}
