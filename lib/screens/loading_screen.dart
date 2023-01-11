import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/screens/location_screen.dart';
import 'package:weather_app/services/location.dart';
import 'package:weather_app/services/network_helper.dart';

import '../utilities/weather_data_model.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  LoadingScreenState createState() => LoadingScreenState();
}

class LoadingScreenState extends State<LoadingScreen> {
  Location location = Location();
  late WeatherData _weatherData;
  void getLocation() async {
    await location.getCurrentLocation();
    _weatherData = await NetworkHelper().getData(location);
    print(_weatherData.main?.temp);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LocationScreen(weatherData: _weatherData)));
  }

  @override
  void initState() {
    getLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data.main.temp);
        } else {
          return SpinKitSquareCircle(
            color: Colors.black,
            size: 50.0,
          );
        }
      },
    ));
  }
}
