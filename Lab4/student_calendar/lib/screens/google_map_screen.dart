import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(42.0039355, 21.4082081),
    zoom: 16.4746,
  );

  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};
  final String _apiKey = 'AIzaSyC_0Paii4Ahpgx6CFpvbEFru-Dl8X8ax14';

  final List<LatLng> _pointsOfInterest = [
    LatLng(42.0045, 21.4087), // Example Point 1
    LatLng(42.0030, 21.4075), // Example Point 2
  ];

  @override
  void initState() {
    super.initState();
    _initializeMarkers();
  }

  void _initializeMarkers() {
    for (int i = 0; i < _pointsOfInterest.length; i++) {
      _markers.add(
        Marker(
          markerId: MarkerId('poi_$i'),
          position: _pointsOfInterest[i],
          infoWindow: InfoWindow(
            title: 'Point of Interest $i',
            snippet: 'Tap for directions',
          ),
          onTap: () {
            _getRoute(_pointsOfInterest[i]);
          },
        ),
      );
    }
  }

  Future<void> _getRoute(LatLng destination) async {
    final String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${_kGooglePlex.target.latitude},${_kGooglePlex.target.longitude}&destination=${destination.latitude},${destination.longitude}&key=$_apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final route = data['routes'][0]['overview_polyline']['points'];
      _setRoute(route);
    } else {
      throw Exception('Failed to load directions');
    }
  }

  void _setRoute(String encodedPolyline) {
    final List<LatLng> points = _decodePolyline(encodedPolyline);

    setState(() {
      _polylines.clear();
      _polylines.add(
        Polyline(
          polylineId: PolylineId('route'),
          points: points,
          color: Colors.blue,
          width: 5,
        ),
      );
    });
  }

  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> points = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int shift = 0, result = 0;
      int b;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dLat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dLat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dLng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dLng;

      points.add(LatLng(lat / 1E5, lng / 1E5));
    }

    return points;
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: _markers,
        polylines: _polylines,
      );
  }
}
