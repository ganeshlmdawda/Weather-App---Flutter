import 'package:flutter/material.dart';

class WeatherInfo extends StatelessWidget {
  final Map<String, dynamic> weatherData;

  WeatherInfo({required this.weatherData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Temperature: ${weatherData['main']['temp']} °C'),
        Text('Humidity: ${weatherData['main']['humidity']} %'),
        Text('Wind Speed: ${weatherData['wind']['speed']} m/s'),
      ],
    );
  }
}
