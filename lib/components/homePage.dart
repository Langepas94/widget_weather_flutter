import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';

import 'package:widget_weather/helpers/weather.dart';
import 'package:permission_handler/permission_handler.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Position? _currentPosition; // = Position(latitude: 0.0, longitude: 0.0, timestamp: null, accuracy: 1.0, altitude: 1.0, heading: 1.0, speed: 1.0, speedAccuracy: 1.0);
  String _city = 'Тест';
  @override
  void initState() {
    super.initState();
    _getCurrent();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(_city)),
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
        _currentPosition!.latitude!, _currentPosition!.longitude);

    Placemark place = p[0];
    setState(() {
      _city = place.locality!;
      print(_currentPosition);
    });
  }
  }
