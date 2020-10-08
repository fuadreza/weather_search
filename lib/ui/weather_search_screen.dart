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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment(1, 1),
              colors: [const Color(0xff00eeee), const Color(0xff0088ff)],
              tileMode: TileMode.repeated),
        ),
        child: SafeArea(
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
                  context.bloc<WeatherCubit>().getWeather();
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Temperature',
              style: TextStyle(fontSize: 21, color: Colors.white),
            ),
            Text(
              '${weather.temperatureCelcius.toInt()}° C',
              style: TextStyle(
                fontSize: 80,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              weather.cityName,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            WeatherForm(),
          ],
        ),
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
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            style: TextStyle(fontSize: 24, color: Colors.white),
            onSubmitted: (value) => getWeatherByCity(context, value),
            controller: _cityNameController,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
                hintText: 'Input city name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                hintStyle: TextStyle(color: Colors.white)),
            onChanged: (value) {
              setState(() {
                _cityName = value;
              });
            },
          ),
        ),
      ],
    );
  }

  void getWeatherByCity(BuildContext context, String cityName) {
    final weatherCubit = context.bloc<WeatherCubit>();
    weatherCubit.getWeatherByCity(cityName);
  }
}
