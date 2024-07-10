import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/weather_detail_screen.dart';
import '../services/weather_api.dart';
import '../widgets/city_search_bar.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  bool _isLoading = false;

  void _onSearch(String city) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final data = await WeatherAPI.fetchWeather(city);

      print('Weather Data: $data');

      setState(() {
        _isLoading = false;
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WeatherDetailScreen(weatherData: data),
        ),
      );
    } 
    on CityNotFoundException catch (e) {
      print('Error occurred: $e');
      setState(() {
        _isLoading = false;
      });
      // Showing an error dialog for city not found
      _showErrorDialog(e.toString());
    } 
    
    on NetworkException catch (e) {
      print('Error occurred: $e');
      setState(() {
        _isLoading = false;
      });

      // Showing an error dialog for network issues
      _showErrorDialog(e.toString());
    }
    
    catch (e) {
      print('Unexpected error occurred: $e');
      setState(() {
        _isLoading = false;
      });
      // Showing a generic error dialog for any other exceptions
      _showErrorDialog('An unexpected error occurred. Please try again later.');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Error', style: TextStyle(color: Colors.red)),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text('Okay', style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              
              CitySearchBar(onSearch: _onSearch),
              const SizedBox(height: 20),
              _isLoading
                  ? const Column(
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 20),
                        Text(
                          'Fetching weather data...',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}


