import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_cubit.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:weather_app/utils/weather_theme.dart';
import 'package:weather_app/views/home_view.dart';
import 'package:weather_app/views/splash_view.dart';

import 'cubits/get_weather_cubit/get_weather_state.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    final weatherService = WeatherService(Dio());

    return BlocProvider(
      create: (_) => GetWeatherCubit(weatherService),
      child: BlocBuilder<GetWeatherCubit, WeatherState>(
        builder: (context, state) {
          Color seedColor = Colors.white;
          Brightness brightness = Brightness.light;

          if (state is WeatherLoadedState) {
            final model = state.weatherModel;

            seedColor =
                WeatherTheme.getMainColor(model.weatherCondition,
                model.temp);

            brightness =
            (model.date.hour >= 18 || model.date.hour <= 6)
                ? Brightness.dark
                : Brightness.light;
          }

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              useMaterial3: true,
              brightness: brightness,
              colorSchemeSeed: seedColor,
            ),
            home: const SplashView(),
          );
        },
      ),
    );
  }
}