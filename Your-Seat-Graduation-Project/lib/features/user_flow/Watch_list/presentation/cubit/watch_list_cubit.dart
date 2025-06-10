import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../data/hive_keys.dart';
import '../../../../../data/hive_storage.dart';
import '../../../movie_details/data/model/movies_details_model/movies_details_model.dart';
import 'watch_list_state.dart';

class WatchListCubit extends Cubit<WatchListState> {
  WatchListCubit() : super(WatchListInitial());
  static WatchListCubit get(context) =>
      BlocProvider.of<WatchListCubit>(context);

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var currentUser;

  Future<void> fetchWatchList() async {
    emit(WatchListLoading());
    if (HiveStorage.get(HiveKeys.role) == Role.google.toString()) {
      currentUser = HiveStorage.getGoogleUser();
    } else {
      currentUser = HiveStorage.getDefaultUser();
    }
    try {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(currentUser.email).get();
      if (!userDoc.exists) {
        emit(WatchListLoaded([]));
        return;
      }
      List<dynamic>? watchListData = userDoc['watch_list'];
      if (watchListData == null || watchListData.isEmpty) {
        emit(WatchListLoaded([]));
        return;
      }
      List<MoviesDetailsModel> watchList = watchListData
          .map((movie) =>
              MoviesDetailsModel.fromJson(movie as Map<String, dynamic>))
          .toList();
      emit(WatchListLoaded(watchList));
    } catch (e) {
      emit(WatchListError("Error fetching watchlist: $e"));
    }
  }

  Future<void> removeFromWatchList(String movieId) async {
    try {
      DocumentReference userDocRef =
          _firestore.collection('users').doc(currentUser.email);
      DocumentSnapshot userDoc = await userDocRef.get();
      if (!userDoc.exists) return;
      List<dynamic> watchListData = List.from(userDoc['watch_list'] ?? []);
      watchListData.removeWhere((movie) => movie['name'] == movieId);
      await userDocRef.update({'watch_list': watchListData});
      fetchWatchList();
    } catch (e) {
      emit(WatchListError("Error removing movie: $e"));
    }
  }
}
