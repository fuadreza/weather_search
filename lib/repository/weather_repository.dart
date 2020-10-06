import 'dart:math';

import 'package:weather_search/model/weather.dart';

abstract class BaseRepository {
  Future<Weather> fetchWeather(String cityName);
}

class WeatherRepository extends BaseRepository {
  @override
  Future<Weather> fetchWeather(String cityName) {
    return Future.delayed(
      Duration(seconds: 1),
      () {
        final random = Random();

        if (random.nextBool()) {
          throw NetworkException();
        }

        return Weather(
          cityName: cityName,
          temperatureCelcius: 20 + random.nextInt(15) + random.nextDouble(),
        );
      },
    );
  }
}

class NetworkException implements Exception {}
