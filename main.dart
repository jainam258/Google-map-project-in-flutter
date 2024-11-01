import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map/locator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps Demo',
      home: MapSample(),
    );
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();
  final Locator locator = Locator();

  static final CameraPosition _UzhNU = CameraPosition(
    target: LatLng(48.6075588, 22.2641117),
    zoom: 15,
  );

  MapType _currentMapType = MapType.normal;

  void _onMapType() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal ? MapType.satellite : MapType.normal;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Google Maps Example'),
        backgroundColor: Colors.green,
      ),
      body: Stack(
        children: [
          StreamBuilder<Set<Marker>>(
              stream: locator.markerStream,
              builder: (context, snapshot) {
                return GoogleMap(
                  mapType: _currentMapType,
                  initialCameraPosition: _UzhNU,
                  onMapCreated: locator.onMapCreated,
                  markers: snapshot.data ?? {},
                );
              }),
          Padding(
            padding: EdgeInsets.all(18),
            child: Align(
              alignment: Alignment.topRight,
              child: FloatingActionButton(
                onPressed: _onMapType,
                materialTapTargetSize: MaterialTapTargetSize.padded,
                backgroundColor: Colors.green,
                child: Icon(Icons.map, size: 36),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
