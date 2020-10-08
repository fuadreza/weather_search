import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_search/bloc/weather_state.dart';
import 'package:weather_search/repository/weather_repository.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository _repository;

  WeatherCubit(this._repository) : super(WeatherInitState());

  Future<void> getWeatherByCity(String cityName) async {
    try {
      emit(WeatherLoadingState());
      final weather = await _repository.fetchWeatherByCity(cityName);
      emit(WeatherLoadedState(weather));
    } on NetworkException {
      emit(WeatherErrorState(
          'Couldn\'t connect to server. Please check your internet connection'));
    }
  }

  Future<void> getWeather() async {
    try {
      emit(WeatherLoadingState());
      final weather = await _repository.fetchWeather();
      emit(WeatherLoadedState(weather));
    }on NetworkException {
      emit(WeatherErrorState(
          'Couldn\'t connect to server. Please check your internet connection'));
    }
  }
}
