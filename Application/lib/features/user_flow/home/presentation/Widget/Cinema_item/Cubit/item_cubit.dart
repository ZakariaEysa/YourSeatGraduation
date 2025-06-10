import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../utils/permissions_manager.dart';
import 'item_state.dart';
import 'package:geolocator/geolocator.dart';

class CinemaItemCubit extends Cubit<CinemaItemState> {
  CinemaItemCubit() : super(CinemaLoading());
  static CinemaItemCubit get(context) =>
      BlocProvider.of<CinemaItemCubit>(context);

  var docs;
  List<Map<String, dynamic>> cinemas = [];
  void fetchCinemas() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('Cinemas').get();
      docs = snapshot.docs;
      cinemas = snapshot.docs.map((doc) => doc.data()).toList();
      //AppLogs.successLog("data is okay  ");
      cinemas = await sortCinemasByDistance(cinemas: cinemas);
      //AppLogs.successLog("data is ready  ");

      emit(CinemaSuccess(cinemas));
    } catch (e) {
      emit(CinemaFailure(e.toString()));
    }
  }

  Future<List<Map<String, dynamic>>> sortCinemasByDistance({
    required List<Map<String, dynamic>> cinemas,
  }) async {
    final currentLocation = await PermissionsManager().getUserLocation();

    if (currentLocation == null) {
      // رجّع الليستة كما هي إذا فشل الحصول على الموقع
      PermissionsManager().showCenteredSnackBar(
          'Could not get current location to sort cinemas.');
      return cinemas;
    }
    //type 'List<_JsonQueryDocumentSnapshot>' is not a subtype of type 'List<Map<String, dynamic>>'
    //AppLogs.successLog(cinemas.toString());

    cinemas.sort((a, b) {
      final double latA = (a['lat'] ?? 0 as num).toDouble();
      final double lngA = (a['lng'] ?? 0 as num).toDouble();

      final double latB = (b['lat'] ?? 0 as num).toDouble();
      final double lngB = (b['lng'] ?? 0 as num).toDouble();

      final distanceA = Geolocator.distanceBetween(
        currentLocation.latitude,
        currentLocation.longitude,
        latA,
        lngA,
      );

      final distanceB = Geolocator.distanceBetween(
        currentLocation.latitude,
        currentLocation.longitude,
        latB,
        lngB,
      );

      return distanceA.compareTo(distanceB); // ترتيب تصاعدي حسب المسافة
    });

    return cinemas;
  }
}
