import 'package:flutter/material.dart';
import 'package:weather_app/pages/home.dart';
import 'package:weather_app/pages/loading.dart';
import 'package:weather_app/pages/locations.dart';


void main() {
  runApp(
    MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Loading(),
        '/Home': (context) => Home(),
        '/Location':(context) => Location(),
      },
    )
  );
}