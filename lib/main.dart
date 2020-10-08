import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_permissions/location_permissions.dart';
import 'package:weather_search/bloc/weather_cubit.dart';
import 'package:weather_search/repository/weather_repository.dart';

import 'ui/weather_search_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  PermissionStatus permission = await LocationPermissions().requestPermissions();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      home: BlocProvider(
        create: (context) => WeatherCubit(WeatherRepository()),
        child: WeatherSearchScreen(),
      ),
    );
  }
}