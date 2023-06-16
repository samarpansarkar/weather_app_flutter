import 'dart:convert';
import 'package:weather_app_flutter/model/weather/weather_data_current.dart';
import 'package:weather_app_flutter/model/weather/weather_data_hourly.dart';
import 'package:weather_app_flutter/utils/api_url.dart';

import '../model/weather/weather_data.dart';
import 'package:http/http.dart' as http;

class FetchWeatherAPI {
  WeatherData? weatherData;

  //processing the data from response -> to json
  Future<WeatherData> processData(lat, lon) async {
    var response = await http.get(Uri.parse(apiURL(lat, lon)));
    var jsonString = jsonDecode(response.body);
    weatherData = WeatherData(WeatherDataCurrent.fromJson(jsonString),
        WeatherDataHourly.fromJson(jsonString));

    return weatherData!;
  }
}
