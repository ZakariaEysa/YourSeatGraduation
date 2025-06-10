import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../../data/local_storage_service/local_storage_service.dart';

class MovieDropdownWidget extends StatefulWidget {
  final String? initialValue;
  final void Function(String?) onChanged;

  const MovieDropdownWidget({
    super.key,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  State<MovieDropdownWidget> createState() => MovieDropdownWidgetState();
}

class MovieDropdownWidgetState extends State<MovieDropdownWidget> {
  List<String> movies = [];
  String? selectedMovie;
  String? lastSavedMovie;
  bool movieError = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMovies();
  }

  Future<void> fetchMovies() async {
    final String email = LocalStorageService.getUserData() ?? "";
    final String cinemaId = extractUsername(email);
    final fetchedMovies = await fetchMoviesFromFirestore(cinemaId);

    setState(() {
      movies = fetchedMovies;
      isLoading = false;
      if (widget.initialValue != null && movies.contains(widget.initialValue)) {
        selectedMovie = widget.initialValue;
      }
    });
  }

  String extractUsername(String email) {
    if (email.contains("@")) {
      return email.substring(0, email.indexOf("@admin.com"));
    } else {
      return "Invalid email format";
    }
  }

  bool validate() {
    setState(() {
      movieError = selectedMovie == null;
      if (!movieError) {
        lastSavedMovie = selectedMovie;
      }
    });
    return !movieError;
  }

  void resetToSaved() {
    setState(() {
      selectedMovie = lastSavedMovie;
      movieError = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      width: 55.w,
      height: 51.h,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: movieError ? Colors.red : Colors.black),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : DropdownButton<String>(
              value: selectedMovie,
              hint: const Text('Movie name',
                  style: TextStyle(color: Colors.black)),
              icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
              items: movies.map((String movie) {
                return DropdownMenuItem<String>(
                  value: movie,
                  child:
                      Text(movie, style: const TextStyle(color: Colors.black)),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  selectedMovie = value;
                  movieError = false;
                });
                widget.onChanged(value);
              },
              isExpanded: true,
              underline: const SizedBox.shrink(),
              dropdownColor: Colors.white,
              style: const TextStyle(color: Colors.black),
            ),
    );
  }
}

// دالة لجلب الأفلام من Firebase
Future<List<String>> fetchMoviesFromFirestore(String cinemaId) async {
  try {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('Cinemas')
        .doc(cinemaId)
        .get();

    final data = docSnapshot.data();
    if (data == null || !data.containsKey('movies')) return [];

    final List<dynamic> moviesList = data['movies'];

    List<String> movieNames = [];
    for (var movie in moviesList) {
      if (movie is Map<String, dynamic> && movie['name'] != null) {
        movieNames.add(movie['name']);
      }
    }

    return movieNames;
  } catch (e) {
    print('Error fetching movies: $e');
    return [];
  }
}
