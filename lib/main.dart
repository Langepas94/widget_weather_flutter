import 'package:flutter/material.dart';
import 'package:widget_weather/components/homePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather',
      home: HomePage(),
    );
  }
}