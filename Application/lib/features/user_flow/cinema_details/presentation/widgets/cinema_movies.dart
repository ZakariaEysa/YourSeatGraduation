import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../movie_details/data/model/movies_details_model/crew.dart';
import '../../../movie_details/data/remote_data_source/movie_details_remote_data_source.dart';
import '../../../movie_details/data/repos_impl/movie_details_repo_impl.dart';
import '../../../movie_details/presentation/cubit/movie_details_cubit.dart';
import '../../../../../utils/navigation.dart';
import '../../../movie_details/data/model/movies_details_model/movies_details_model.dart';
import '../../../movie_details/presentation/views/movie_details.dart';
import '../../../now_playing/presentation/widgets/playing_movies.dart';

class CinemaMovies extends StatelessWidget {
  final List movies;

  const CinemaMovies({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 8.0.w, top: 8.0.h),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 20.h,
          crossAxisCount: 2,
          crossAxisSpacing: 1.w,
          childAspectRatio: 0.45,
        ),
        itemCount: movies.length,
        itemBuilder: (context, movieIndex) {
          final movie = movies[movieIndex];

          return BlocProvider(
            create: (context) => MovieDetailsCubit(
                MovieDetailsRepoImpl(MovieDetailsRemoteDataSourceImpl())),
            child: GestureDetector(
              onTap: () {
                navigateTo(
                    context: context,
                    screen: MovieDetails(
                        model: MoviesDetailsModel(
                            ageRating: movie["ageRating"],
                            castImages: movie["cast_images"],
                            cast: movie["cast"],
                            category: movie["category"],
                            crew: Crew(
                                director: movie["crew"]["director"],
                                producer: movie["crew"]["producer"],
                                writer: movie["crew"]["writer"]),
                            description: movie["description"],
                            duration: movie["duration"],
                            language: movie["language"],
                            name: movie["name"],
                            posterImage: movie["poster_image"],
                            rating: movie["rating"],
                            releaseDate: movie["release_date"],
                            trailer: movie["trailer"])));
              },
              child: PlayingMovies(
                movies: MoviesDetailsModel(
                    ageRating: movie["ageRating"],
                    castImages: movie["cast_images"],
                    cast: movie["cast"],
                    category: movie["category"],
                    crew: Crew(
                        director: movie["crew"]["director"],
                        producer: movie["crew"]["producer"],
                        writer: movie["crew"]["writer"]),
                    description: movie["description"],
                    duration: movie["duration"],
                    language: movie["language"],
                    name: movie["name"],
                    posterImage: movie["poster_image"],
                    rating: movie["rating"],
                    releaseDate: movie["release_date"],
                    trailer: movie["trailer"]),
                rate: movie["rating"].toString(),
                duration: movie["duration"] ?? "",
                category: movie["category"] ?? "",
                image: movie["poster_image"] ?? "",
                title: movie["name"] ?? "",
              ),
            ),
          );
        },
      ),
    );
  }
}
