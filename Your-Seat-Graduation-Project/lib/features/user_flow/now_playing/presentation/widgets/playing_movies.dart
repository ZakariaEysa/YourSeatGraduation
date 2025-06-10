import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../widgets/network_image/image_replacer.dart';
import '../../../Watch_list/favorite_movies_provider/favorite_movies_provider.dart';
import '../../../movie_details/data/model/movies_details_model/movies_details_model.dart';
import '../../../movie_details/presentation/cubit/movie_details_cubit.dart';

class PlayingMovies extends StatefulWidget {
  final String image;
  final String title;
  final String category;
  final String duration;
  final String rate;
  final MoviesDetailsModel movies;

  const PlayingMovies({
    super.key,
    required this.image,
    required this.title,
    required this.category,
    required this.duration,
    required this.rate,
    required this.movies,
  });

  @override
  State<PlayingMovies> createState() => _PlayingMoviesState();
}

class _PlayingMoviesState extends State<PlayingMovies> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // تحقق إذا كان الفيلم موجودًا في قائمة Watchlist
    final favoriteMoviesProvider =
        Provider.of<FavoriteMoviesProvider>(context, listen: false);
    _isBookmarked = favoriteMoviesProvider.favoriteMovies
        .any((movie) => movie.name == widget.movies.name);
    BlocProvider.of<MovieDetailsCubit>(context)
        .getRate(widget.title.toString());
  }

  bool _isBookmarked = false;
  num rate = 0;
  @override
  Widget build(BuildContext context) {
    var lang = S.of(context);
    final theme = Theme.of(context);

    bool isBase64(String? imageUrl) {
      final base64Pattern = RegExp(r'^[A-Za-z0-9+/=]+$');
      return base64Pattern.hasMatch(imageUrl ?? "");
    }

    return Padding(
      padding: EdgeInsets.only(right: 8.w, left: 8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // Prevent unnecessary stretching
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: isBase64(widget.image)
                ? Image.memory(
                    base64Decode(widget.image ?? ""),
                    width: 200.w,
                    height: 250.h,
                    fit: BoxFit.cover,
                  )
                : ImageReplacer(
                    imageUrl: widget.image,
                    width: 200.w,
                    height: 250.h,
                    fit: BoxFit.cover,
                  ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            widget.title,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: theme.textTheme.bodySmall!.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                "assets/images/cinemastar.png",
                width: 17.w,
                height: 18.h,
              ),
              SizedBox(
                width: 10.w,
              ),
              BlocConsumer<MovieDetailsCubit, MovieDetailsState>(
                listener: (context, state) {
                  // AppLogs.debugLog(state.toString()); // Removed: was used for logging state in BlocConsumer
                  if (state is GetRateError) {
                    // AppLogs.debugLog(state.error.toString()); // Removed: was used for logging error in BlocConsumer
                    rate = 4.2;
                  }
                  if (state is GetRateSuccess) {
                    rate = double.parse(state.rate.split('/')[0]);
                    rate = rate >= 6 ? rate.toDouble() / 2 : rate.toDouble();
                    if (rate == 0) {
                      rate = 4.1;
                    }
                  }

                  // AppLogs.debugLog(widget.title.toString()); // Removed: was used for logging title in BlocConsumer

                  // AppLogs.debugLog(rate.toString()); // Removed: was used for logging rate in BlocConsumer
                },
                builder: (context, state) {
                  return Text(
                    rate.toString(),
                    style:
                        theme.textTheme.bodyMedium!.copyWith(fontSize: 12.sp),
                  );
                },
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (!_isBookmarked) {
                      Provider.of<FavoriteMoviesProvider>(context,
                              listen: false)
                          .addMovie(widget.movies);
                      // print("Added to favorites: \\${widget.movies.name}"); // Removed: was used for debugging favorite addition
                    } else {
                      Provider.of<FavoriteMoviesProvider>(context,
                              listen: false)
                          .removeMovie(widget.movies);
                      // print("Removed from favorites: \\${widget.movies.name}"); // Removed: was used for debugging favorite removal
                    }
                    _isBookmarked = !_isBookmarked;
                  });
                },
                child: Icon(
                  Icons.bookmark,
                  color: _isBookmarked
                      ? Colors.purple
                      : Colors.grey.withOpacity(0.15),
                  size: 30.sp,
                ),
              ),
            ],
          ),
          Spacer(),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                "assets/icons/clock.png",
                width: 18.w,
                height: 18.h,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              SizedBox(
                width: 10.w,
              ),
              Text(
                widget.duration,
                style: theme.textTheme.bodyMedium!.copyWith(fontSize: 12.sp),
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                "assets/icons/video.png",
                width: 18.w,
                height: 18.h,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              SizedBox(
                width: 10.w,
              ),
              Text(
                widget.category,
                style: theme.textTheme.bodyMedium!.copyWith(fontSize: 12.sp),
              ),
            ],
          ),
          Spacer(),
          //SizedBox(height: 15.h,)
        ],
      ),
    );
  }
}
