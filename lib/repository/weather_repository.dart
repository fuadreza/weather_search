import 'dart:math';

import 'package:weather_search/model/weather.dart';
import 'package:weather_search/service/dio_helper.dart';
import 'package:weather_search/service/location_service.dart';
import 'package:weather_search/utils/my_config.dart' as config;

abstract class BaseRepository {
  Future<Weather> fetchWeather();

  Future<Weather> fetchWeatherByCity(String cityName);
}

class WeatherRepository extends BaseRepository {
  String weatherUrl = 'https://api.openweathermap.org/data/2.5/weather';
  String apiKey = config.apiKey;

  Weather _weather = Weather();

  LocationService location = LocationService();

  @override
  Future<Weather> fetchWeather() async {
    await location.getCurrentLocation();

    var url =
        '$weatherUrl?lat=${location.latitude}&lon=${location.longitude}&appId=$apiKey&units=metric';

    DioHelper dio = DioHelper(url);
    var weatherData = await dio.getData();

    if (weatherData == null) {
      print('data is empty');
      _weather = Weather(cityName: 'Noo place', temperatureCelcius: 0);
    } else {
      print('data is available');
      _weather = Weather(
          cityName: weatherData['name'], temperatureCelcius: weatherData['main']['temp']);
    }
    return _weather;
  }

  @override
  Future<Weather> fetchWeatherByCity(String cityName) async {
    var url = '$weatherUrl?q=$cityName&appid=$apiKey&units=metric';

    DioHelper dio = DioHelper(url);
    var weatherData = await dio.getData();

    if (weatherData == null) {
      print('data is empty');
      _weather = Weather(cityName: cityName, temperatureCelcius: 0);
    } else {
      print('data is Available');
      int temperature = weatherData['main']['temp'];
      _weather = Weather(
          cityName: cityName, temperatureCelcius: temperature.toDouble());
    }
    return _weather;
  }
}

class NetworkException implements Exception {}
