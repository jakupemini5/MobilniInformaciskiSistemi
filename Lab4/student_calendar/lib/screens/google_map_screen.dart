import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:student_calendar/models/ExamModel.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  List<ExamModel> exams = [];
  CameraPosition? _initialPosition; // Dynamic initial position
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};
  final String _apiKey = 'AIzaSyC_0Paii4Ahpgx6CFpvbEFru-Dl8X8ax14';

  @override
  void initState() {
    super.initState();
    _initializeMap();
    _initializeMarkers();
  }

  Future<void> _initializeMap() async {
    // Request location permissions
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // Fetch the current location
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _initialPosition = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 16.4746,
      );
    });
  }

  Future<void> _loadExamItems() async {
    final String response = await rootBundle.loadString('assets/examsList.json');
    final List<dynamic> rawData = json.decode(response);
    final List<ExamModel> data = rawData.map((item) => ExamModel.fromJson(item)).toList();

    setState(() {
      exams = data;
    });
  }

  void _initializeMarkers() async {
    await _loadExamItems();
    for (int i = 0; i < exams.length; i++) {
      _markers.add(
        Marker(
          markerId: MarkerId('poi_$i'),
          position: LatLng(exams[i].latitude!, exams[i].longitude!),
          infoWindow: InfoWindow(
            title: exams[i].name,
            snippet: 'Click here to get Route',
          ),
          onTap: () async {
            await _getRoute(LatLng(exams[i].latitude!, exams[i].longitude!));
          },
        ),
      );
    }
  }

  Future<void> _getRoute(LatLng destination) async {
    if (_initialPosition == null) return;

    final String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${_initialPosition!.target.latitude},${_initialPosition!.target.longitude}&destination=${destination.latitude},${destination.longitude}&key=$_apiKey';

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
    return _initialPosition == null
        ? Center(child: CircularProgressIndicator())
        : GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _initialPosition!,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers: _markers,
            polylines: _polylines,
          );
  }
}
