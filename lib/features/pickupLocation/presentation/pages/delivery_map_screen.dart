import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flowery_tracking/core/utils/constants/app_assets.dart';
import 'package:flowery_tracking/features/pickupLocation/domain/useCases/get_locations_use_case.dart';
import 'package:flowery_tracking/features/pickupLocation/domain/useCases/get_route_use_case.dart';
import 'package:flowery_tracking/features/pickupLocation/domain/useCases/update_driver_location_on_server_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class CustomMapScreen extends StatefulWidget {
  const CustomMapScreen({super.key});

  @override
  State<CustomMapScreen> createState() => _CustomMapScreenState();
}

class _CustomMapScreenState extends State<CustomMapScreen> {
  GoogleMapController? _mapController;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};
  late final GetLocationsUseCase _getLocationsUseCase;
  late final GetRouteUseCase _getRouteUseCase;
  late final UpdateDriverLocationOnServerUseCase _updateDriverLocationOnServerUseCase;



  // Replace with your actual API key
  static const String _apiKey = 'AIzaSyA6C_wzcGqqL_YgoZE-nFmy0-i87SbmM4c';

  // Example locations
  final LatLng _startLocation = const LatLng(37.7749, -122.4194); // San Francisco
  final LatLng _endLocation = const LatLng(37.8044, -122.2712); // Oakland

  @override
  void initState() {
    super.initState();
    _initializeMap();
  }

  Future<void> _initializeMap() async {
    // Load custom markers
    final startIcon = await _createCustomMarkerFromSvg(
      Assets.assetsImagesFrame2,
      100,
    );

    final endIcon = await _createCustomMarkerFromSvg(
      Assets.assetsImagesFrame3,
      100,
    );

    // Add markers
    setState(() {
      _markers.add(
        Marker(
          markerId: const MarkerId('start'),
          position: _startLocation,
          icon: startIcon,
          infoWindow: const InfoWindow(title: 'Start Point'),
        ),
      );

      _markers.add(
        Marker(
          markerId: const MarkerId('end'),
          position: _endLocation,
          icon: endIcon,
          infoWindow: const InfoWindow(title: 'End Point'),
        ),
      );
    });

    // Fetch and draw route
    await _drawRoute(_startLocation, _endLocation);
  }

  // Convert SVG to BitmapDescriptor
  Future<BitmapDescriptor> _createCustomMarkerFromSvg(
      String svgString,
      int size,
      ) async {
    final PictureInfo pictureInfo = await vg.loadPicture(
      SvgStringLoader(svgString),
      null, // You can pass a theme or other options here if needed
    );

    final ui.Picture picture = pictureInfo.picture;

    // screen DPI
    final ui.Image image = picture.toImageSync(size, size);
    final ByteData? bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    return BitmapDescriptor.fromBytes(bytes!.buffer.asUint8List());

  }

  // Fetch route from Routes API
  Future<void> _drawRoute(LatLng start, LatLng end) async {
    final url = Uri.parse('https://routes.googleapis.com/directions/v2:computeRoutes');

    final requestBody = {
      "origin": {
        "location": {
          "latLng": {
            "latitude": start.latitude,
            "longitude": start.longitude,
          }
        }
      },
      "destination": {
        "location": {
          "latLng": {
            "latitude": end.latitude,
            "longitude": end.longitude,
          }
        }
      },
      "travelMode": "DRIVE",
      "routingPreference": "TRAFFIC_AWARE",
      "computeAlternativeRoutes": false,
      "routeModifiers": {
        "avoidTolls": false,
        "avoidHighways": false,
        "avoidFerries": false
      },
      "languageCode": "en-US",
      "units": "IMPERIAL"
    };

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'X-Goog-Api-Key': _apiKey,
          'X-Goog-FieldMask': 'routes.duration,routes.distanceMeters,routes.polyline.encodedPolyline',
        },
        body: json.encode(requestBody),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final encodedPolyline = data['routes'][0]['polyline']['encodedPolyline'];
        final points = _decodePolyline(encodedPolyline);

        setState(() {
          _polylines.add(
            Polyline(
              polylineId: const PolylineId('route'),
              points: points,
              color: Colors.blue,
              width: 5,
              patterns: [PatternItem.dash(20), PatternItem.gap(10)],
            ),
          );
        });

        // Adjust camera to show entire route
        _fitBounds(points);
      } else {
        debugPrint('Route API Error: ${response.statusCode}');
        debugPrint('Response: ${response.body}');
      }
    } catch (e) {
      debugPrint('Error fetching route: $e');
    }
  }

  // Decode polyline from Routes API
  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> points = [];
    int index = 0;
    int len = encoded.length;
    int lat = 0;
    int lng = 0;

    while (index < len) {
      int b;
      int shift = 0;
      int result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      points.add(LatLng(lat / 1E5, lng / 1E5));
    }
    return points;
  }

  // Fit camera bounds to show all route points
  void _fitBounds(List<LatLng> points) {
    if (_mapController == null || points.isEmpty) return;

    double minLat = points.first.latitude;
    double maxLat = points.first.latitude;
    double minLng = points.first.longitude;
    double maxLng = points.first.longitude;

    for (var point in points) {
      if (point.latitude < minLat) minLat = point.latitude;
      if (point.latitude > maxLat) maxLat = point.latitude;
      if (point.longitude < minLng) minLng = point.longitude;
      if (point.longitude > maxLng) maxLng = point.longitude;
    }

    final bounds = LatLngBounds(
      southwest: LatLng(minLat, minLng),
      northeast: LatLng(maxLat, maxLng),
    );

    _mapController!.animateCamera(
      CameraUpdate.newLatLngBounds(bounds, 50),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Google Maps'),
        backgroundColor: Colors.blue,
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _startLocation,
          zoom: 12,
        ),
        markers: _markers,
        polylines: _polylines,
        onMapCreated: (controller) {
          _mapController = controller;
          // Apply custom map style
          _setMapStyle(controller);
        },
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        mapToolbarEnabled: true,
        zoomControlsEnabled: false,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Recenter map to show route
          if (_polylines.isNotEmpty) {
            final points = _polylines.first.points;
            _fitBounds(points);
          }
        },
        child: const Icon(Icons.center_focus_strong),
      ),
    );
  }

  // Apply custom map style (dark theme example)
  Future<void> _setMapStyle(GoogleMapController controller) async {
    final String mapStyle =  await rootBundle.loadString(Assets.assetsJsonSilverMapStyle);
    controller.setMapStyle(mapStyle);
  }
}