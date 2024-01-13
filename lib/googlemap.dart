import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';


class ActiveRoutePage extends StatefulWidget {
  final String fromAddress;
  final String toAddress;


ActiveRoutePage({required this.fromAddress, required this.toAddress});


Future<LatLng> _getCoordinates(String location) async {
  List<Location> locations = await locationFromAddress(location);

  return LatLng(locations.last.latitude, locations.last.longitude);
}



  @override
  _ActiveRoutePageState createState() => _ActiveRoutePageState();
}

class _ActiveRoutePageState extends State<ActiveRoutePage> {
  late GoogleMapController mapController;
  Set<Marker> markers = Set();

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Route Map'),
      ),
      body: Column(
        children: [
          Container(
            height: 200, // Adjust the height as needed
            child: GoogleMap(
              onMapCreated: (controller) {
                mapController = controller;
                _addMarkers();
              },
              initialCameraPosition: CameraPosition(
                target: LatLng(-34.397, 150.644), // Initial map center
                zoom: 10,
              ),
              markers: markers,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Route from ${widget.fromAddress} to ${widget.toAddress}'),
                // Display other route details
              ],
            ),
          ),
        ],
      ),
    );
  }

void _addMarkers() async {
  print('Adding markers');
  print('From Address: ${widget.fromAddress}');
  print('To Address: ${widget.toAddress}');

  List<Location> startLocations = await locationFromAddress(widget.fromAddress);
  List<Location> endLocations = await locationFromAddress(widget.toAddress);

  print('Start Location: ${LatLng(startLocations.last.latitude, startLocations.last.longitude)}');
  print('End Location: ${LatLng(endLocations.last.latitude, endLocations.last.longitude)}');

  markers.add(
    Marker(
      markerId: MarkerId('fromMarker'),
      position: LatLng(startLocations.last.latitude, startLocations.last.longitude),
      infoWindow: InfoWindow(title: 'From'),
    ),
  );
  markers.add(
    Marker(
      markerId: MarkerId('toMarker'),
      position: LatLng(endLocations.last.latitude, endLocations.last.longitude),
      infoWindow: InfoWindow(title: 'To'),
    ),
  );

  setState(() {}); // Ensure the widget rebuilds after adding markers
}

}
