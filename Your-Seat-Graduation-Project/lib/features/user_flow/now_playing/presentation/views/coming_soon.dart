import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../widgets/loading_indicator.dart';
import '../../../movie_details/data/remote_data_source/movie_details_remote_data_source.dart';
import '../../../movie_details/data/repos_impl/movie_details_repo_impl.dart';
import '../../../movie_details/presentation/cubit/movie_details_cubit.dart';
import '../../../../../widgets/scaffold/scaffold_f.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../utils/navigation.dart';
import '../../../movie_details/data/model/movies_details_model/movies_details_model.dart';
import '../../../movie_details/presentation/views/movie_details.dart';
import '../widgets/playing_movies.dart';

class ComingSoons extends StatefulWidget {
  const ComingSoons({super.key});

  @override
  State<ComingSoons> createState() => _ComingSoonsState();
}

List<Map<String, dynamic>> movies = [];

class _ComingSoonsState extends State<ComingSoons> {
  Future<List<MoviesDetailsModel>> _fetchMovies() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('Movies').get();
      return snapshot.docs
          .map((doc) => MoviesDetailsModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      print("Error fetching movies: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    var lang = S.of(context);
    final theme = Theme.of(context);
    return ScaffoldF(
      body: FutureBuilder<List<MoviesDetailsModel>>(
        future: _fetchMovies(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingIndicator();
          } else if (snapshot.hasError) {
            return Center(child: Text("Error fetching movies"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("Error fetching movies"));
          }

          final movies = snapshot.data!;

          return Padding(
            padding: EdgeInsets.only(left: 8.0.w, top: 8.0.h),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 20.h,
                crossAxisCount: 2, // Number of columns
                crossAxisSpacing: 1.w,
                childAspectRatio: 0.45,
                // Adjust to fit the card design
              ),
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return BlocProvider(
                  create: (context) => MovieDetailsCubit(
                      MovieDetailsRepoImpl(MovieDetailsRemoteDataSourceImpl())),
                  child: GestureDetector(
                    onTap: () {
                      navigateTo(
                          context: context,
                          screen: MovieDetails(
                            model: movie,
                          ));
                    },
                    child: PlayingMovies(
                      movies: movie,
                      rate: movie.rating.toString(),
                      duration: movie.duration ?? "",
                      category: movie.category ?? "",
                      image: movie.posterImage ?? "",
                      title: movie.name ?? "",
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
