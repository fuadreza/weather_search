import 'package:weather_search/model/weather.dart';

abstract class WeatherState {
  const WeatherState();
}

class WeatherInitState extends WeatherState {
  const WeatherInitState();
}

class WeatherLoadingState extends WeatherState {}

class WeatherLoadedState extends WeatherState {
  final Weather weather;

  WeatherLoadedState(this.weather);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WeatherLoadedState && other.weather == weather;
  }

  @override
  int get hashCode => weather.hashCode;
}

class WeatherErrorState extends WeatherState {
  final String message;
  WeatherErrorState(this.message);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WeatherErrorState && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
