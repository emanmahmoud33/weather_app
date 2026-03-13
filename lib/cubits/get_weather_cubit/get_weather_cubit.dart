import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_state.dart';
import '../../models/weather_model.dart';
import '../../services/weather_service.dart';
import 'get_weather_state.dart';

class GetWeatherCubit extends Cubit<WeatherState> {
  final WeatherService weatherService;

  GetWeatherCubit(this.weatherService) : super(WeatherInitialState());

  WeatherModel? weatherModel;

  Future<void> getWeather({required String cityName}) async {
    emit(WeatherLoadingState());

    try {
      weatherModel =
      await weatherService.getCurrentWeather(cityName: cityName);

      emit(WeatherLoadedState(weatherModel!));
    } catch (e) {
      if (kDebugMode) {
        print('ERROR 👉 $e');
      }
      emit(WeatherFailureState(
        message: 'Failed to load weather. Please try again.',
      ));
    }
  }
}
