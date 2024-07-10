import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherAPI {
  static const _apiKey = 'cfa804f6b5b1c6cc0115fe617b9a1ebc';

  static Future<Map<String, dynamic>> fetchWeather(String city) async {
    try {
      final uri = Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$_apiKey&units=metric');
      print('Fetching weather data for $city...');
      final response = await http.get(uri);
      print('Response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        print('Weather data received: ${response.body}');
        return json.decode(response.body);
      } else if (response.statusCode == 404) {
        print('City not found.');
        throw CityNotFoundException('City not found. Please enter a valid city name.');
      } else {
        print('Failed to load weather data.');
        throw WeatherAPIException('Failed to load weather data');
      }
    } on CityNotFoundException catch (e) {
      print('City not found error: $e');
      throw e;
    } on WeatherAPIException catch (e) {
      print('Weather API error: $e');
      throw e;
    } catch (e) {
      print('Network error: $e');
      throw NetworkException('Network error. Please try again later.');
    }
  }
}

class CityNotFoundException implements Exception {
  final String message;
  CityNotFoundException(this.message);

  @override
  String toString() => message;
}

class WeatherAPIException implements Exception {
  final String message;
  WeatherAPIException(this.message);

  @override
  String toString() => message;
}

class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);

  @override
  String toString() => message;
}
