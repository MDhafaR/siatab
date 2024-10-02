class Koordinat {
  final double latitude;
  final double longitude;

  Koordinat({required this.latitude, required this.longitude});

  factory Koordinat.fromJson(Map<String, dynamic> json) {
    return Koordinat(
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  @override
  String toString() {
    return '$latitude, $longitude';
  }
}