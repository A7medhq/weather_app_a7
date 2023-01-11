import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/services/location.dart';

import '../utilities/weather_data_model.dart';

class NetworkHelper {
  Future<WeatherData> getData(Location location) async {
    var url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=a1461ae522a45d9d92f4b6549ac227cb&units=metric');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      return WeatherData.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('aaa');
    }
  }

  Future<WeatherData> getDataByCity(String city) async {
    var url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=${city}&appid=a1461ae522a45d9d92f4b6549ac227cb&units=metric');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      return WeatherData.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('aaa');
    }
  }
}
