import 'package:flutter/material.dart';
import 'package:weather_app/screens/city_screen.dart';

import '../services/weather.dart';
import '../utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  var weatherData;
  LocationScreen({super.key, this.weatherData});

  @override
  LocationScreenState createState() => LocationScreenState();
}

class LocationScreenState extends State<LocationScreen> {
  ImageProvider networkImage =
      const NetworkImage('https://source.unsplash.com/random/?cloud');

  ImageProvider assetImage = const AssetImage('images/location_background.jpg');

  bool doneLoading = false;
  @override
  void initState() {
    networkImage
        .resolve(ImageConfiguration())
        .addListener(ImageStreamListener((_, __) {
      setState(() {
        doneLoading = true;
      });
    }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Container(
          //   constraints: const BoxConstraints.expand(),
          //   child: NetworkImageTest(
          //     assetImage: assetImage,
          //     networkImage: networkImage,
          //   ),
          // ),
          Container(
            constraints: const BoxConstraints.expand(),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: doneLoading ? networkImage : assetImage,
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.8), BlendMode.dstATop),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextButton(
                      onPressed: () {},
                      child: const Icon(
                        Icons.near_me,
                        size: 50.0,
                        color: kSecondaryColor,
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        var result = await Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => CityScreen()));

                        setState(() {
                          widget.weatherData = result;
                        });
                      },
                      child: const Icon(
                        Icons.location_city,
                        size: 50.0,
                        color: kSecondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${WeatherModel().getWeatherIcon((widget.weatherData.weather[0].id).toInt())}',
                      style: TextStyle(fontSize: 74),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          widget.weatherData.main!.temp.round().toString(),
                          style: kTempTextStyle,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 10),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              height: 7,
                              width: 35,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)
                                  // shape: BoxShape.circle,
                                  ),
                            ),
                            const Text(
                              'now',
                              style: TextStyle(
                                fontSize: 30.0,
                                fontFamily: 'Spartan MB',
                                letterSpacing: 13,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 24.0, bottom: 24),
                child: Text(
                  "${WeatherModel().getMessage((widget.weatherData.main!.temp).toInt())} in ${widget.weatherData.name}!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
