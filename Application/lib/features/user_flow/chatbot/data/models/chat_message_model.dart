enum MessageType { user, bot }

class ChatMessage {
  final String message;
  final MessageType type;
  final List<MovieRecommendation>? recommendations;

  ChatMessage({
    required this.message,
    required this.type,
    this.recommendations,
  });
}

class MovieRecommendation {
  final String title;
  final String genre;
  final double imdbScore;
  final int releaseYear;
  final List<String> cast;
  final String director;

  MovieRecommendation({
    required this.title,
    required this.genre,
    required this.imdbScore,
    required this.releaseYear,
    required this.cast,
    required this.director,
  });

  factory MovieRecommendation.fromJson(Map<String, dynamic> json) {
    return MovieRecommendation(
      title: json['title'],
      genre: json['genre'],
      imdbScore: json['imdb_score'].toDouble(),
      releaseYear: json['release_year'],
      cast: List<String>.from(json['cast']),
      director: json['director'],
    );
  }
}
