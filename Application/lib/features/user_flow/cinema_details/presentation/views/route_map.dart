import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import '../../../../../widgets/scaffold/scaffold_f.dart';
import '../../../../../../widgets/loading_indicator.dart';

const String googleApiKey = 'AIzaSyD7VmrfzhvvuttRBIRVcWix-1eOjLtI1bU';

class RouteMapPage extends StatefulWidget {
  final double destinationLat;
  final double destinationLng;

  const RouteMapPage({
    super.key,
    required this.destinationLat,
    required this.destinationLng,
  });

  @override
  _RouteMapPageState createState() => _RouteMapPageState();
}

class _RouteMapPageState extends State<RouteMapPage> {
  GoogleMapController? mapController;
  Set<Polyline> polylines = {};
  LatLng? currentLocation;
  LatLng? destination;

  @override
  void initState() {
    super.initState();
    _initLocationAndRoute();
  }

  Future<void> _initLocationAndRoute() async {
    // print("📡 Getting current location..."); // Removed: was used for debugging location fetch
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      // print("⚠️ Location services are disabled."); // Removed: was used for debugging location services
      if (!serviceEnabled) {
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      // print("❌ Location permission denied."); // Removed: was used for debugging permission denied
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // print("❌ Location permissions are permanently denied."); // Removed: was used for debugging permanently denied
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        currentLocation = LatLng(position.latitude, position.longitude);
        destination = LatLng(widget.destinationLat, widget.destinationLng);
      });

      // print("✅ Current location: $currentLocation"); // Removed: was used for debugging current location
      // print("🎯 Destination location: $destination"); // Removed: was used for debugging destination location

      await _drawRoute();
    } catch (e) {
      // print("❌ Error getting location: $e"); // Removed: was used for debugging location errors
    }
  }

  Future<void> _drawRoute() async {
    // print("🛣️ Starting to draw route..."); // Removed: was used for debugging route drawing
    if (currentLocation == null || destination == null) {
      // print("⚠️ Locations are null, skipping route drawing."); // Removed: was used for debugging null locations
      return;
    }

    try {
      PolylinePoints polylinePoints = PolylinePoints();

      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        request: PolylineRequest(
          origin: PointLatLng(
              currentLocation!.latitude, currentLocation!.longitude),
          destination:
              PointLatLng(destination!.latitude, destination!.longitude),
          mode: TravelMode.driving,
        ),
        googleApiKey: googleApiKey,
      );

      // print("📍 Route status: ${result.status}"); // Removed: was used for debugging route status
      // print("📌 Points count: ${result.points.length}"); // Removed: was used for debugging points count

      if (result.points.isNotEmpty) {
        List<LatLng> routePoints = result.points
            .map((point) => LatLng(point.latitude, point.longitude))
            .toList();

        setState(() {
          polylines.add(Polyline(
            polylineId: PolylineId("route"),
            color: Colors.blue,
            width: 5,
            points: routePoints,
          ));
        });

        // print("✅ Route drawn successfully."); // Removed: was used for debugging successful route draw
      } else {
        // print("❌ No route found."); // Removed: was used for debugging no route found
      }
    } catch (e) {
      // print("❌ Error drawing route: $e"); // Removed: was used for debugging route drawing errors
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldF(
      appBar: AppBar(
          title: Text(
        "خريطة المسار",
        style: Theme.of(context).textTheme.bodyLarge,
      )),
      body: currentLocation == null
          ? const LoadingIndicator()
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: currentLocation!,
                zoom: 14,
              ),
              polylines: polylines,
              onMapCreated: (controller) => mapController = controller,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              markers: {
                Marker(
                  markerId: MarkerId("destination"),
                  position: destination!,
                  infoWindow: InfoWindow(title: "الوجهة"),
                ),
              },
            ),
    );
  }
}
