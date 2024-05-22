import 'dart:convert';
import 'package:weatherly/models/weather_data.dart';
import 'package:http/http.dart' as http;
import 'package:weatherly/models/weather_data_current.dart';
import 'package:weatherly/models/weather_data_daily.dart';
import 'package:weatherly/models/weather_data_hourly.dart';
import 'package:weatherly/utils/api_url.dart';

class FetchWeatherAPI {
  WeatherData? weatherData;

  Future<WeatherData> processData(lat, lon) async {
    final response = await http.get(Uri.parse(apiURL(lat, lon)));
    final jsonString = jsonDecode(response.body);

    weatherData = WeatherData(
      WeatherDataCurrent.fromJson(jsonString),
      WeatherDataHourly.fromJson(jsonString),
      WeatherDataDaily.fromJson(jsonString),
    );

    return weatherData!;
  }
}
