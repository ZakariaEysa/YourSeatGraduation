import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repos/movie_details_repo.dart';

part 'movie_details_state.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  static MovieDetailsCubit get(context) =>
      BlocProvider.of<MovieDetailsCubit>(context);
  final MovieDetailsRepo movieDetailsRepo;
  MovieDetailsCubit(this.movieDetailsRepo) : super(MovieDetailsInitial());

  Future<void> getCinemas(String movieName) async {
    emit(GetCinemasLoading());
    final result = await movieDetailsRepo.getCinemas(movieName);
    result.fold(
      (failure) => emit(GetCinemasError(failure.errorMsg)),
      (cinemas) => emit(GetCinemasSuccess(cinemas)),
    );
  }

  Future<void> getRate(String movieId) async {
    emit(GetRateLoading());
    final result = await movieDetailsRepo.getRate(movieId);
    result.fold(
      (failure) => emit(GetRateError(failure.errorMsg)),
      (rate) => emit(GetRateSuccess(rate)),
    );
  }
}
