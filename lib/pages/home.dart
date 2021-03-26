import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/services/weather.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  void getMyLocationTemp() async {
    Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best)
        .timeout(Duration(seconds: 5));

    WeatherApi weatherApi = WeatherApi.fromCoordinates(
        latitude: position.latitude, longitude: position.longitude);
    await weatherApi.getTempByCoordinates();
    data['CityName'] = weatherApi.cityName;
    data['Temp'] = weatherApi.temp;
    data['Weather'] = weatherApi.weather;
    data['MinTemp'] = weatherApi.lowTemp;
    data['MaxTemp'] = weatherApi.highTemp;
    data['FeelsLike'] = weatherApi.feelsLike;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;

    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: SafeArea(
          child: Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () async {
                    dynamic result =
                        await Navigator.pushNamed(context, '/Location');
                    if (result != Null) {
                      setState(() {
                        data = {
                          'CityName': result['CityName'],
                          'Temp': result['Temp'],
                          'MinTemp': result['MinTemp'],
                          'MaxTemp': result['MaxTemp'],
                          'Weather': result['Weather'],
                          'FeelsLike': result['FeelsLike'],
                        };
                      });
                    }
                  },
                  child: Text(
                    data['CityName'].toString().toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 50.0,
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                ),
                // child: Text(
                //   data['CityName'].toString().toUpperCase(),
                //   style: TextStyle(
                //     fontSize: 50.0,
                //     letterSpacing: 2.0,
                //   ),
                // ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  '${data['Weather']}',
                  style: TextStyle(
                    fontSize: 20.0,
                    letterSpacing: 3.0,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  "${data['Temp']}\u2103",
                  style: TextStyle(
                    fontSize: 30.0,
                    letterSpacing: 2.0,
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  'L:${data['MinTemp']}\tH:${data['MaxTemp']}',
                  style: TextStyle(
                    fontSize: 15.0,
                    letterSpacing: 2.0,
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  'Feels Like: ${data['FeelsLike']}\u2103',
                  style: TextStyle(
                    fontSize: 20.0,
                    letterSpacing: 2.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          setState(() {
            getMyLocationTemp();
          });
        },
        child: Icon(Icons.my_location),
      ),
    );
  }
}
