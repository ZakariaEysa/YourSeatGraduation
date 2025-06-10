@JS()
library google_maps_interop;

import 'package:js/js.dart';

@JS('google.maps.Map')
class GMap {
  external GMap(dynamic mapDiv, MapOptions options);
  external MapsEventListener addListener(String eventName, Function callback);
  external set center(LatLng latLng);
}

@JS()
@anonymous
class MapOptions {
  external factory MapOptions({
    LatLng? center,
    num? zoom,
    MapRestriction? restriction, // 👈 دي السطر الجديد
  });
}

@JS('google.maps.LatLng')
class LatLng {
  external LatLng(num lat, num lng);
  external num lat();
  external num lng();
}

@JS('google.maps.Marker')
class Marker {
  external Marker(MarkerOptions options);
  external void setMap(GMap? map); // ← دي الميثود الصح من Google Maps API
}

@JS()
@anonymous
class MarkerOptions {
  external factory MarkerOptions();

  external LatLng? get position;
  external set position(LatLng? p);

  external GMap? get map;
  external set map(GMap? m);
}

@JS()
class MapsEventListener {
  external void remove();
}

@JS('google.maps.LatLngBounds')
class LatLngBounds {
  external LatLngBounds(LatLng southwest, LatLng northeast);
}

@JS()
@anonymous
class MapRestriction {
  external factory MapRestriction({LatLngBounds? latLngBounds});
}
