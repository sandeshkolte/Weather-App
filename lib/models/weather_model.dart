class Weather {
  final String cityName;
  final String base;
  final double temperature;
  final String mainCondition;
  final String description;

  Weather(
      {required this.cityName,
      required this.base,
      required this.temperature,
      required this.mainCondition,
      required this.description});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
        cityName: json['name'],
        base: json['base'],
        temperature: json['main']['temp'].toDouble(),
        mainCondition: json['weather'][0]['main'],
        description: json['weather'][0]['description']);
  }
}
