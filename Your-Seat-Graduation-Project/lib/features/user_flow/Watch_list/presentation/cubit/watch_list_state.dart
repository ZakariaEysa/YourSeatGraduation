import '../../../movie_details/data/model/movies_details_model/movies_details_model.dart';

abstract class WatchListState {}

class WatchListInitial extends WatchListState {}

class WatchListLoading extends WatchListState {}

class WatchListLoaded extends WatchListState {
  final List<MoviesDetailsModel> watchList;
  WatchListLoaded(this.watchList);
}

class WatchListError extends WatchListState {
  final String message;
  WatchListError(this.message);
}
