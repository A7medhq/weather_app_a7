import 'package:flutter/material.dart';
import 'package:weather_app/utilities/weather_data_model.dart';

import '../services/network_helper.dart';
import '../utilities/constants.dart';
import 'location_screen.dart';

class CityScreen extends StatefulWidget {
  const CityScreen({super.key});

  @override
  CityScreenState createState() => CityScreenState();
}

class CityScreenState extends State<CityScreen> {
  WeatherData? _weatherData;
  String temp = '';
  TextEditingController textController = TextEditingController();
  bool _validate = false;

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            opacity: 0.5,
            image: AssetImage('images/city_background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: TextButton(
                    onPressed: () {},
                    child: const Icon(
                      Icons.arrow_back_ios,
                      size: 50.0,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20.0),
                  child: null,
                ),
                TextField(
                  style: TextStyle(color: Colors.white),
                  controller: textController,
                  decoration: InputDecoration(
                      errorText: _validate ? 'Wrong Value' : null,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white))),
                ),
                SizedBox(
                  height: 20,
                ),
                TextButton(
                  onPressed: () async {
                    if (await NetworkHelper()
                            .getDataByCity(textController.text) !=
                        null) {
                      _weatherData = (await NetworkHelper()
                          .getDataByCity(textController.text))!;
                    } else {
                      _weatherData = null;
                    }

                    if (_weatherData != null) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LocationScreen(
                                weatherData: _weatherData,
                              )));
                      setState(() {
                        _validate = false;
                      });
                    } else {
                      setState(() {
                        _validate = true;
                      });
                    }
                  },
                  child: const Text(
                    'Get Weather',
                    style: kButtonTextStyle,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  temp,
                  style: TextStyle(color: Colors.white, fontSize: 60),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
