import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_search/bloc/weather_cubit.dart';
import 'package:weather_search/bloc/weather_state.dart';
import 'package:weather_search/model/weather.dart';

class WeatherSearchScreen extends StatelessWidget {
  void searchWeatherByCity(String cityName) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocConsumer<WeatherCubit, WeatherState>(
            listener: (context, state) {
              if (state is WeatherErrorState) {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is WeatherInitState) {
                return displayForm();
              } else if (state is WeatherLoadingState) {
                return displayLoading();
              } else if (state is WeatherLoadedState) {
                return displayLoadedData(state.weather);
              } else {
                return displayForm();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget displayForm() {
    return Center(child: WeatherForm());
  }

  Widget displayLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget displayLoadedData(Weather weather) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Temperature: ${weather.temperatureCelcius.toString()}',
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            weather.cityName,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          WeatherForm(),
        ],
      ),
    );
  }
}

class WeatherForm extends StatefulWidget {
  @override
  _WeatherFormState createState() => _WeatherFormState();
}

class _WeatherFormState extends State<WeatherForm> {
  String _cityName;

  TextEditingController _cityNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          onSubmitted: (value) => getWeatherByCity(context, value),
          controller: _cityNameController,
          decoration: InputDecoration(
            hintText: 'Input city name',
          ),
          onChanged: (value) {
            setState(() {
              _cityName = value;
            });
          },
        ),
      ],
    );
  }

  void getWeatherByCity(BuildContext context, String cityName) {
    final weatherCubit = context.bloc<WeatherCubit>();
    weatherCubit.getWeather(cityName);
  }
}
