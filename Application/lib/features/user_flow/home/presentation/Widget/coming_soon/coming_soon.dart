import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourseatgraduationproject/features/user_flow/now_playing/cubit/coming_soon_cubit.dart';
import 'package:yourseatgraduationproject/features/user_flow/now_playing/cubit/coming_soon_state.dart';
import '../../../../../../utils/navigation.dart';
import '../../../../movie_details/data/model/movies_details_model/movies_details_model.dart';
import '../../../../movie_details/presentation/views/movie_details.dart';
import 'coming_card.dart';
import '../../../../../../widgets/loading_indicator.dart';

class ComingSoon extends StatefulWidget {
  const ComingSoon({super.key});

  @override
  State<ComingSoon> createState() => _ComingSoonState();
}

class _ComingSoonState extends State<ComingSoon> {
  final PageController _pageController = PageController(
    viewportFraction: 0.5,
    initialPage: 1,
  );

  @override
  void initState() {
    super.initState();

    final cubit = context.read<ComingSoonCubit>();
    final currentState = cubit.state;
// AppLogs.successLog(currentState.toString());
    if (currentState is! ComingSoonLoaded &&
        currentState is! ComingSoonLoading) {
      cubit.fetchComingMovies();
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ComingSoonCubit, ComingSoonState>(
      builder: (context, state) {
        if (state is ComingSoonLoading) {
          return const LoadingIndicator();
        } else if (state is ComingSoonError) {
          return Center(child: Text(state.message));
        } else if (state is ComingSoonLoaded) {
          final movies = state.movies;

          if (movies.isEmpty) {
            return const Center(child: Text('No movies found'));
          } else {
            return PageView.builder(
              controller: _pageController,
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return GestureDetector(
                  onTap: () {
                    navigateTo(
                      context: context,
                      screen: MovieDetails(
                        model: MoviesDetailsModel.fromJson(movie),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: ComingCard(
                      title: movie['name'] ?? 'Unknown Title',
                      genre: movie['category'] ?? 'Unknown Category',
                      date: movie['release_date'] ?? 'Unknown Date',
                      imageUrl: movie['poster_image'] ??
                          'https://via.placeholder.com/300',
                    ),
                  ),
                );
              },
            );
          }
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
