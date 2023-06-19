import 'dart:io';

import 'constants.dart';
import 'fetch.dart';

const weatherMapURL = "https://api.openweathermap.org/data/2.5/weather";

class WeatherFetch {
  Future<dynamic> getWeatherByCoordinates(double lat, double lon) async {
    FetchHelper fetchData = new FetchHelper("$weatherMapURL?lat=$lat&lon=$lon&appid=$openWeatherMapApiKey&unitc=metric");

    var decodedData = await fetchData.getData(); // json
    return decodedData;
  }

  Future<dynamic> getWeatherByName(String cityName) async {
    FetchHelper fetchData = new FetchHelper("$weatherMapURL?q=$cityName&appid=$openWeatherMapApiKey&unitc=metric");

    var decodedData = await fetchData.getData();
    return decodedData;
  }
}