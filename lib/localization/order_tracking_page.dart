import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/utils/constants/api_constants.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrderTrackingPage extends StatefulWidget {
  const OrderTrackingPage({super.key});

  @override
  State<StatefulWidget> createState() => OrderTrackingPageState();
}

class OrderTrackingPageState extends State<OrderTrackingPage> {
  final Completer<GoogleMapController> _controller = Completer();

  static const LatLng sourceLocation = LatLng(37.33500926, -122.03272188);
  static const LatLng destination = LatLng(37.33429383, -122.06600055);

  List<LatLng> polylineCoordinates = [];

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      APIConstants.google_api_key,
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      PointLatLng(destination.latitude, destination.longitude),
    );

    if (result.points.isNotEmpty) {
      result.points.forEach(
        (PointLatLng point) =>
            polylineCoordinates.add(LatLng(point.latitude, point.longitude)),
      );
      setState(() {});
    }
  }


  @override
  void initState() {
    getPolyPoints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Track order",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: sourceLocation,
          zoom: 13.5,
        ),
        polylines: {
          Polyline(
            polylineId: PolylineId("route"),
            points: polylineCoordinates,
          ),
        },
        markers: {
          const Marker(markerId: MarkerId("source"), position: sourceLocation),
          const Marker(
              markerId: MarkerId("destination"), position: destination),
        },
      ),
    );
  }
}
