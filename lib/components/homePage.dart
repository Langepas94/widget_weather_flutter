import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';

import 'package:widget_weather/helpers/weather.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:widget_weather/components/searchForm.dart';
import 'package:widget_weather/components/weatherCard.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 late Position _currentPosition; // = Position(latitude: 0.0, longitude: 0.0, timestamp: null, accuracy: 1.0, altitude: 1.0, heading: 1.0, speed: 1.0, speedAccuracy: 1.0);
  String _city = 'Тест';
  int _temp = 0;
  String _icon = '04n';
  String _description = '';
  WeatherFetch _weatherFetch = WeatherFetch();
  @override
  void initState() {
    super.initState();
    _getCurrent();
  }

  void updateData(weatherData) {
    setState(() {
      if (weatherData != null) {
        _temp = weatherData['main']['temp'].toInt();
        _icon = weatherData['weather'][0]['icon'];
        _description = weatherData['main']['feels_like'].toString();
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
      child: Column(
        children: [
          Search(parentCallback: _changeCity),
          Text(_city, style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold
          ),
            textAlign: TextAlign.center,),
          WeatherCard(title: _description, temperature: _temp, iconCode: _icon)
        ],
      ),
    ),
    ),
    );
  }
  _getCurrent() async {

   Geolocator.requestPermission();
    Geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        print(position.longitude);
        _currentPosition = position;

      });
      _getCityAndWeather();
    }).catchError((e) {
      print(e);
    });

  }

  _getCityAndWeather() async {

    List<Placemark> p = await placemarkFromCoordinates(
        _currentPosition.latitude, _currentPosition!.longitude);

    Placemark place = p[0];
    final data = await _weatherFetch.getWeatherByCoordinates(_currentPosition.latitude, _currentPosition!.longitude);
    updateData(data);
    setState(() {
      _city = place.locality!;
    });
  }

  _changeCity(city) async {
    try {
      final data = await _weatherFetch.getWeatherByName(city);
      debugPrint(data.toString());
      updateData(data);
setState(() {
  _city = city;
});
    } catch(e) {
      print(e);
    }
  }
  }
