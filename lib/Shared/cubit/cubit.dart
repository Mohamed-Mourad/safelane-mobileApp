import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_routes/google_maps_routes.dart';
import '../cubit/states.dart';
import '../models/routeDetails.dart';
import '../network/remote/routes_service.dart';
import '../components/constants.dart';
import '../network/local/backend_endpoints.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  List obstaclesOnRoute = [];

  Map<String, bool> obstacleFilters = {
    "pothole": false,
    "crack": false,
    "wet": false,
    "muddy": false,
  };

  void updateObstacleFilters(String type) {
    obstacleFilters[type] = !obstacleFilters[type]!;
    emit(AppUpdateObstacleFiltersState());
  }

  Map<String, bool> severityFilters = {
    "1": false,
    "2": false,
    "3": false,
    "4": false,
    "5": false,
  };

  void updateSeverityFilters(String severity) {
    severityFilters[severity] = !severityFilters[severity]!;
    emit(AppUpdateSeverityFiltersState());
  }

  Set<Marker> markers = {};

  Map<String, double> dataMap = {};

  int routeRating = 0;

  List<LatLng> points = [
    LatLng(0, 0),
    LatLng(0, 0),
  ];

  LatLng center = LatLng(0, 0);

  String destination = "";

  MapsRoutes route = new MapsRoutes();

  void setMarkers () {
    if(this.markers.isNotEmpty) this.markers.clear();
    if(this.obstacleFilters.containsValue(true)){
      obstaclesOnRoute = obstaclesOnRoute.where((element) => obstacleFilters[element.type] == true).toList();
    }
    if(this.severityFilters.containsValue(true)){
      obstaclesOnRoute = obstaclesOnRoute.where((element) => severityFilters[element.severity.toString()] == true).toList();
    }
    obstaclesOnRoute.forEach((element) {
      markers.add(Marker(
        markerId: MarkerId(element.type),
        position: LatLng(element.latitude, element.longitude),
        icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueRed,
        ),
        infoWindow: InfoWindow(
          title: 'Severity: ',
          snippet: element.severity.toString(),
        ),
      ));
    });
  }


  Future<LatLng> calculatePolylineCenter(List<LatLng> points) async {
    double totalX = 0.0;
    double totalY = 0.0;
    int numPoints = points.length;

    for (int i = 0; i < numPoints; i++) {
      totalX += points[i].latitude;
      totalY += points[i].longitude;
    }

    double centerX = totalX / numPoints;
    double centerY = totalY / numPoints;

    return LatLng(centerX, centerY);
  }

  Future<void> addSource(double lat, double lng) async {
    //this.points.add(LatLng(lat, lng));
    this.points[0] = LatLng(lat, lng);
  }

  Future<void> addDestination(double lat, double lng, String destination) async {
    //this.points.add(LatLng(lat, lng));
    this.points[1] = LatLng(lat, lng);
    this.destination = destination;
    print("test: addDestination done ${this.destination.toString()}");
    emit(DestinationUpdatedState());
  }

  Future<void> drawRouteCubit() async {
    if(state is RouteDrawnState) return;
    if(this.route.routes.isNotEmpty) this.route.routes.clear();
    await RoutesService.drawRoute(this.points, 'Route', Colors.blue, apiKey);
    this.route = RoutesService.route;
    print("test: drawRouteCubit done");
    await fetchRouteDetails();
    await updateStatsDataMap();
    emit(RouteDrawnState());
  }

  Future<void> fetchRouteDetails() async {
    List<LatLng> polylinePoints = RoutesService.getPolylinePoints();
    RouteDetails routeDetails = await getRouteDetails(polylinePoints);
    this.obstaclesOnRoute = routeDetails.obstacles;
    this.routeRating = routeDetails.rating;

    this.center = await calculatePolylineCenter(polylinePoints);
    setMarkers();

    print("test: fetchRouteDetails done");
  }

  Future<void> updateStatsDataMap() async {
    if(this.dataMap.isNotEmpty) return;
    double potholes = 0;
    double cracks = 0;
    double wet = 0;
    double muddy = 0;

    this.obstaclesOnRoute.forEach((obstacle) {
      if(obstacle.type == "pothole") potholes++;
      else if(obstacle.type == "crack") cracks++;
      else if(obstacle.type == "wet") wet++;
      else if(obstacle.type == "mud") muddy++;
    });

    this.dataMap["potholes"] = potholes;
    this.dataMap["cracks"] = cracks;
    this.dataMap["wet"] = wet;
    this.dataMap["mud"] = muddy;
    this.dataMap = dataMap;

    print("test: updateStatsDataMap done");
  }

  void deleteRoute() {
    this.points[1] = LatLng(0, 0);
    this.obstaclesOnRoute = [];
    this.dataMap = {};
    this.markers = {};
    this.routeRating = 0;
    this.center = LatLng(0, 0);
    RoutesService.clearRoutes();
    emit(AppInitialState());
  }

}