import 'package:equatable/equatable.dart';
import 'package:yourseatgraduationproject/features/admin_flow/moives/data/models/crew_model.dart';

class MoviesDetailsModel extends Equatable {
  final List<dynamic>? castImages;
  final Map<String, dynamic>? crewImages;
  final List<dynamic>? cast;
  final Crew? crew;
  final String? category;
  final num? rating;
  final String? description;
  final String? status;
  final String? censorship;
  final String? language;
  final String? ageRating;
  final String? duration;
  final String? name;
  final String? posterImage;
  final String? releaseDate;
  final String? trailer;

  const MoviesDetailsModel({
    this.crewImages,
    this.status,
    this.censorship,
    this.castImages,
    this.cast,
    this.crew,
    this.category,
    this.rating,
    this.description,
    this.language,
    this.ageRating,
    this.duration,
    this.name,
    this.posterImage,
    this.releaseDate,
    this.trailer,
  });

  factory MoviesDetailsModel.fromJson(Map<String, dynamic> json) {
    return MoviesDetailsModel(
      castImages: json['cast_images'] as List<dynamic>?,
      crewImages: json['crew_images'] as Map<String, dynamic>? ??
          {
            'director': "https://picsum.photos/150/130",
            'producer': "https://picsum.photos/150/130",
            'writer': "https://picsum.photos/150/130"
          },
      cast: json['cast'] as List<dynamic>?,
      crew: json['crew'] == null
          ? null
          : Crew.fromJson(json['crew'] as Map<String, dynamic>),
      category: json['category'] as String?,
      rating: (json['rating'] as num?),
      description: json['description'] as String?,
      status: json['status'] as String?,
      language: json['language'] as String?,
      ageRating: json['age_rating'] as String?,
      duration: json['duration'] as String?,
      name: json['name'] as String?,
      posterImage: json['poster_image'] as String?,
      releaseDate: json['release_date'] as String?,
      trailer: json['trailer'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        // 'Comments': comments?.map((e) => e.toJson()).toList(),
        'cast_images': castImages,
        'crew_images': crewImages,
        'cast': cast,
        'crew': crew?.toJson(),
        'category': category,
        'rating': rating,
        'description': description,
        'language': language,
        'age_rating': ageRating,
        'duration': duration,
        'name': name,
        'poster_image': posterImage,
        'release_date': releaseDate,
        'trailer': trailer,
        'status': status
      };

  @override
  List<Object?> get props {
    return [
      // comments,
      crewImages,
      castImages,
      cast,
      crew,
      category,
      rating,
      description,
      language,
      ageRating,
      duration,
      name,
      posterImage,
      releaseDate,
      trailer,
      status
    ];
  }
}
