import 'package:weather/weather.dart';

class WeatherApi {
  String cityName;
  double temp;
  double lowTemp;
  double highTemp;
  double feelsLike;
  String weather;
  String apiKey = '0fde9de20a397260fb156c3bc88a6711';
  double latitude;
  double longitude;

  WeatherApi({this.cityName});

  WeatherApi.fromCoordinates({this.latitude, this.longitude});

  Future<void> getTempByCity() async {
    try {
      WeatherFactory wf = new WeatherFactory(apiKey);

      Weather w = await wf.currentWeatherByCityName(cityName);

      // print(w);

      temp = double.parse((w.temperature.celsius).toStringAsFixed(1));
      //print(temp);
      lowTemp = double.parse((w.tempMin.celsius).toStringAsFixed(1));
      //print(lowTemp);
      highTemp = double.parse((w.tempMax.celsius).toStringAsFixed(1));
      //print(highTemp);
      weather = w.weatherDescription.trimRight().toUpperCase();
      // print(weather);
      feelsLike = double.parse((w.tempFeelsLike.celsius).toStringAsFixed(1));
      // print(feelsLike);

      //print(temp);
    } catch (e) {
      print('error: $e');
    }
  }

  Future<void> getTempByCoordinates() async {
    try {
      WeatherFactory wf = new WeatherFactory(apiKey);

      Weather w = await wf.currentWeatherByLocation(latitude, longitude);

      print(w);

      cityName = w.areaName;
      // print(cityName);

      temp = double.parse((w.temperature.celsius).toStringAsFixed(1));
      //print(temp);
      lowTemp = double.parse((w.tempMin.celsius).toStringAsFixed(1));
      //print(lowTemp);
      highTemp = double.parse((w.tempMax.celsius).toStringAsFixed(1));
      //print(highTemp);
      weather = w.weatherDescription.trimRight().toUpperCase();
      // print(weather);
      feelsLike = double.parse((w.tempFeelsLike.celsius).toStringAsFixed(1));
      // print(feelsLike);

    } catch (e) {
      print('error: $e');
    }
  }
}
