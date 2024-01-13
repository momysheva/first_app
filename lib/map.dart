import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
// import 'dart:async';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// void main() => runApp(MyMapApp());

// class MyMapApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MapScreen(
//         fromAddress: 'Nursultan Nazarbayev Avenue, Nur-Sultan, Kazakhstan',
//         toAddress: 'Bayterek Tower, Nur-Sultan, Kazakhstan',
//       ),
//     );
//   }
// }

class MapScreen extends StatefulWidget {
  final String fromAddress;
  final String toAddress;

  MapScreen({required this.fromAddress, required this.toAddress});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Set<Marker> markers = Set();
  Set<Polyline> polylines = Set<Polyline>();
  List<Location> startLocations = [];
  List<Location> endLocations = [];

  @override
  void initState() {
    super.initState();
    _setPolyline();
    _addMarkers();
  }

  void _addMarkers() async {
    startLocations = await locationFromAddress(widget.fromAddress);
    endLocations = await locationFromAddress(widget.toAddress);

    markers.add(
      Marker(
        markerId: MarkerId('fromMarker'),
        position: LatLng(startLocations.last.latitude, startLocations.last.longitude),
        infoWindow: InfoWindow(
          title: 'From',
          snippet: widget.fromAddress,
        ),
      ),
    );

    markers.add(
      Marker(
        markerId: MarkerId('toMarker'),
        position: LatLng(endLocations.last.latitude, endLocations.last.longitude),
        infoWindow: InfoWindow(
          title: 'To',
          snippet: widget.toAddress,
        ),
      ),
    );

    setState(() {});
  }

    void _setPolyline() async{
    startLocations = await locationFromAddress(widget.fromAddress);
    endLocations = await locationFromAddress(widget.toAddress);
    polylines.add(
      Polyline(
        polylineId: PolylineId('polyline'),
        color: Colors.blue,
        width: 5,
        points: [
          LatLng(startLocations.last.latitude, startLocations.last.longitude),
          LatLng(endLocations.last.latitude, endLocations.last.longitude),
        ],
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Map App'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(51.169392, 71.449074)
,
          zoom: 12.0,
        ),
        markers: markers,
        polylines: polylines,
      ),
    );
  }

  
}
