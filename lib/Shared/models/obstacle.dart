class Obstacle{
  String obstacleIMG;
  String type;
  int severity;
  double latitude;
  double longitude;

  Obstacle({required this.obstacleIMG, required this.type, required this.severity, required this.latitude, required this.longitude});

  factory Obstacle.fromJson(Map<String, dynamic> json) {
    return Obstacle(
      latitude: json['latitude'],
      longitude: json['longitude'],
      type: json['type'],
      obstacleIMG: json['obstacleIMG'],
      severity: json['severity'],
    );
  }

}