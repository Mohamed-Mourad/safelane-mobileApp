import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_routes/google_maps_routes.dart';

class RoutesService {

  static final MapsRoutes route = new MapsRoutes();

  static Future<void> drawRoute(
      List<LatLng> points, String routeName, Color color, String apiKey,
      {TravelModes travelMode = TravelModes.driving}) async {
    await route.drawRoute(points, routeName, color, apiKey, travelMode: travelMode);
  }

  static List<LatLng> getPolylinePoints(){
    final polylinePoints = route.routes.isNotEmpty
        ? route.routes.elementAt(0).points
        : [];
    return List.from(polylinePoints);
  }

  static void clearRoutes(){
    route.routes.clear();
  }

}
