import 'package:equatable/equatable.dart';

import 'crew.dart';

class MoviesDetailsModel extends Equatable {
  final List<dynamic>? castImages;
  final List<dynamic>? cast;
  final Crew? crew;
  final String? category;
  final num? rating;
  final String? description;
  final String? language;
  final String? ageRating;
  final String? duration;
  final String? name;
  final String? posterImage;
  final String? releaseDate;
  final String? trailer;

  const MoviesDetailsModel({
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
      // comments: (json['Comments'] as List<dynamic>?)
      //     ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
      //     .toList(),
      castImages: json['cast_images'] as List<dynamic>?,
      cast: json['cast'] as List<dynamic>?,
      crew: json['crew'] == null
          ? null
          : Crew.fromJson(json['crew'] as Map<String, dynamic>),
      category: json['category'] as String?,
      rating: (json['rating'] as num?),
      description: json['description'] as String?,
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
      };

  @override
  List<Object?> get props {
    return [
      // comments,
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
    ];
  }
}
