import 'package:weatherly/models/weather_data_current.dart';
import 'package:weatherly/models/weather_data_daily.dart';
import 'package:weatherly/models/weather_data_hourly.dart';

class WeatherData {
  final WeatherDataCurrent? current;
  final WeatherDataHourly? hourly;
  final WeatherDataDaily? daily;

  WeatherData([this.current, this.hourly, this.daily]);

  // function to fetch these values
  WeatherDataCurrent getCurrentWeather() => current!;
  WeatherDataHourly getHourlyWeather() => hourly!;
  WeatherDataDaily getDailyWeather() => daily!;
}
