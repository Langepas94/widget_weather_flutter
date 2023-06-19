import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'constants.dart';
import 'fetch.dart';

const weatherMapURL = "https://api.openweathermap.org/data/2.5/weather";

class WeatherFetch {
  final String apiKey = "7af63772b9ed73068bec766f73b1724c";
  final String baseUrl = 'https://api.openweathermap.org/data/2.5';

  Future<Map<String, dynamic>> getWeatherByCoordinates(
      double latitude, double longitude) async {
    final url =
        '$baseUrl/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return jsonData;
    } else {
      throw Exception('Failed to fetch weather data');
    }
  }

  Future<dynamic> getWeatherByName(String cityName) async {
    final String baseUrl = "$weatherMapURL?q=$cityName&appid=$openWeatherMapApiKey&units=metric";
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return jsonData;
    } else {
      throw Exception('Failed to fetch weather data');
    }
  }
}