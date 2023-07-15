import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../models/obstacle.dart';
import '../../models/routeDetails.dart';


Future<RouteDetails> getRouteDetails(List polylinePoints) async {
  final url = 'http://0000:8080/obstacles/routeDetails';  // USE LOCAL IPv4 ADDRESS INSTEAD OF 0000
  final headers = {'Content-Type': 'application/json'};
  final body = jsonEncode(
    polylinePoints
        .map((point) => {'lat': point.latitude, 'lng': point.longitude})
        .toList(),
  );
  final response = await http.post(
      Uri.parse(url), headers: headers, body: body);
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final obstacleList = (data['obstacles'] as List)
        .map((obstacle) => Obstacle.fromJson(obstacle))
        .toList();
    final rating = (data['rating']);
    RouteDetails routeDetails = RouteDetails(obstacles: obstacleList, rating: rating);
    return routeDetails;
  } else {
    throw Exception('Failed to send route data to the backend');
  }
}
