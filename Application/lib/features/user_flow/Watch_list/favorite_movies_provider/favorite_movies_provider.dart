import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import '../../../../utils/app_logs.dart';
import '../../movie_details/data/model/movies_details_model/movies_details_model.dart';

class FavoriteMoviesProvider extends ChangeNotifier {
  List<MoviesDetailsModel> _favoriteMovies = [];

  List<MoviesDetailsModel> get favoriteMovies => _favoriteMovies;

  FavoriteMoviesProvider() {
    _loadFavoriteMovies(); // تحميل البيانات عند إنشاء الكلاس
  }

  void addMovie(MoviesDetailsModel movie) async {
    if (!_favoriteMovies.contains(movie)) {
      _favoriteMovies.add(movie);
      await _saveFavoriteMovies();
      notifyListeners();
    }
  }

  void removeMovie(MoviesDetailsModel movie) async {
    _favoriteMovies.remove(movie);
    await _saveFavoriteMovies();
    notifyListeners();
  }

  Future<void> _saveFavoriteMovies() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<String> movieList =
          _favoriteMovies.map((movie) => jsonEncode(movie.toJson())).toList();
      await prefs.setStringList('favorite_movies', movieList);
    } catch (e) {
      // AppLogs.errorLog("Error saving favorite movies: $e"); // Removed: was used for logging error saving favorite movies
    }
  }

  Future<void> _loadFavoriteMovies() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<String>? movieList = prefs.getStringList('favorite_movies');
      if (movieList != null) {
        _favoriteMovies = movieList
            .map((movie) => MoviesDetailsModel.fromJson(jsonDecode(movie)))
            .toList();
        notifyListeners();
      }
    } catch (e) {
      // AppLogs.errorLog("Error loading favorite movies: $e"); // Removed: was used for logging error loading favorite movies
    }
  }
}
