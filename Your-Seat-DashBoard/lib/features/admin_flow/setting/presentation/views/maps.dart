import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:js/js_util.dart';

import '../cubit/settings_cubit.dart';
import 'google_maps_interop.dart';

class MapPickerPage extends StatefulWidget {
  const MapPickerPage({super.key});

  @override
  State<MapPickerPage> createState() => _MapPickerPageState();
}

class _MapPickerPageState extends State<MapPickerPage> {
  DivElement? _mapElement;
  GMap? _map;
  Marker? _marker;

  double? selectedLat;
  double? selectedLng;
  String? selectedAddress;

  @override
  void initState() {
    super.initState();
    // register map HTML view
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'map-element',
      (int viewId) {
        _mapElement = DivElement()
          ..id = 'map'
          ..style.width = '100%'
          ..style.height = '100%';
        _initMap();
        return _mapElement!;
      },
    );
  }

  void _initMap() {
    final options = MapOptions(
      center: LatLng(26.8206, 30.8025), // مركز مصر
      zoom: 6,
      restriction: MapRestriction(
        latLngBounds: LatLngBounds(
          LatLng(22.0, 24.7), // جنوب غرب مصر
          LatLng(31.7, 36.9), // شمال شرق مصر
        ),
      ),
    );

    _map = GMap(_mapElement!, options);

    _map!.addListener('click', allowInterop((event) async {
      final lat = event.latLng.lat();
      final lng = event.latLng.lng();

      print("📍 Clicked on: $lat, $lng");

      setState(() {
        selectedLat = lat;
        selectedLng = lng;
      });
      setState(() {
        _marker?.setMap(null);

        _marker = Marker(MarkerOptions()
          ..position = LatLng(lat, lng)
          ..map = _map);
      });

      final address = await getAddressFromLatLng(lat, lng);
      setState(() {
        selectedAddress = address;
      });

      print("🏠 Address: $address");
    }));
  }

  Future<String> getAddressFromLatLng(double lat, double lng) async {
    const apiKey = 'AIzaSyD7VmrfzhvvuttRBIRVcWix-1eOjLtI1bU';
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$apiKey';

    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body);

    if (data['status'] == 'OK') {
      return data['results'][0]['formatted_address'];
    } else {
      return 'Address not found';
    }
  }

  void saveLocation() {
    if (selectedLat != null && selectedLng != null && selectedAddress != null) {
      print("✅ Location Saved:");
      print("Lat: $selectedLat, Lng: $selectedLng");
      print("Address: $selectedAddress");

      SettingsCubit.get(context).lat = selectedLat;
      SettingsCubit.get(context).lng = selectedLng;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('📌 تم حفظ الموقع')),
      );
    } else {
      print("⚠️ مفيش موقع متحدد");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('اختار مكان من على الخريطة')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("حدد موقع السينما")),
      body: Column(
        children: [
          const Expanded(
            child: HtmlElementView(viewType: 'map-element'),
          ),
          if (selectedAddress != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("📍 العنوان المحدد: $selectedAddress"),
            ),
          ElevatedButton.icon(
            onPressed: saveLocation,
            icon: const Icon(Icons.save),
            label: const Text("حفظ الموقع"),
          ),
        ],
      ),
    );
  }
}
