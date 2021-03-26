import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/services/weather.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  void setupWeather() async {
    WeatherApi weatherApi = WeatherApi(cityName: 'Indore');
    await weatherApi.getTempByCity();

    Navigator.pushNamed(context, '/Home', arguments: {
      'CityName': weatherApi.cityName,
      'Temp': weatherApi.temp,
      'MinTemp': weatherApi.lowTemp,
      'MaxTemp': weatherApi.highTemp,
      'Weather': weatherApi.weather,
      'FeelsLike': weatherApi.feelsLike,
    });
  }

  @override
  void initState() {
    super.initState();
    setupWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: Center(
        child: SpinKitFadingCircle(
          color: Colors.white,
          size: 60.0,
        ),
      ),
    );
  }
}
