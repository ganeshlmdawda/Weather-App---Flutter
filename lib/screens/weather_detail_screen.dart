import 'package:flutter/material.dart';
import '../widgets/weather_info.dart';

class WeatherDetailScreen extends StatelessWidget {
  final Map<String, dynamic> weatherData;

  WeatherDetailScreen({required this.weatherData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: weatherData.isNotEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: WeatherInfo(weatherData: weatherData),
                    ),
                  ),
                ],
              )
            : const Center(
                child: Text(
                  'No data available',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
      ),
    );
  }
}
