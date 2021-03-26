import 'package:flutter/material.dart';
import 'package:weather_app/services/weather.dart';
//import 'package:geolocator/geolocator.dart';

class Location extends StatefulWidget {
  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  String current = 'Current Location';

  List<WeatherApi> weather = [
    WeatherApi(cityName: 'Delhi'),
    WeatherApi(cityName: 'Kolkata'),
    WeatherApi(cityName: 'Mumbai'),
    WeatherApi(cityName: 'Chennai'),
    WeatherApi(cityName: 'Ahmedabad'),
    WeatherApi(cityName: 'Indore'),
    WeatherApi(cityName: 'Jaipur'),
  ];

  void updateWeather(index) async {
    WeatherApi weatherApi = weather[index];
    await weatherApi.getTempByCity();

    Navigator.pop(context, {
      'CityName': weatherApi.cityName,
      'Temp': weatherApi.temp,
      'MinTemp': weatherApi.lowTemp,
      'MaxTemp': weatherApi.highTemp,
      'Weather': weatherApi.weather,
      'FeelsLike': weatherApi.feelsLike,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[200],
      appBar: AppBar(
        title: Text('Choose a Location'),
        backgroundColor: Colors.indigo[400],
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: weather.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.5, horizontal: 2.0),
            child: Card(
              child: ListTile(
                title: Text(weather[index].cityName),
                onTap: () {
                  updateWeather(index);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
