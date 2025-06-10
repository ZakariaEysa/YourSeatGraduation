import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../widgets/scaffold/scaffold_f.dart';
import '../../favorite_movies_provider/favorite_movies_provider.dart';
import '../widgets/watch_list_part.dart';

class WatchList extends StatelessWidget {
  const WatchList({super.key});

  @override
  Widget build(BuildContext context) {
    var lang = S.of(context);

    final favoriteMoviesProvider = Provider.of<FavoriteMoviesProvider>(context);
    final favoriteMovies = favoriteMoviesProvider.favoriteMovies;

    return ScaffoldF(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(lang.watchlist),
      ),
      body: favoriteMovies.isEmpty
          ? Center(
              child: Text(
                lang.sorryNoWatchListMoviesYet,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontSize: 18),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: List.generate(
                  favoriteMovies.length,
                  (index) {
                    final movie = favoriteMovies[index];
                    return Column(
                      children: [
                        WatchListPart(
                          image: movie.posterImage ?? 'assets/images/img_1.png',
                          title: movie.name ?? "",
                          time: '${movie.releaseDate} | ${movie.duration}',
                          smallimage: 'assets/images/star.png',
                          smalltitle: "${movie.rating}",
                          onRemove: () {
                            favoriteMoviesProvider.removeMovie(movie);
                          },
                        ),
                        Image.asset('assets/images/line.png'),
                      ],
                    );
                  },
                ),
              ),
            ),
    );
  }
}
