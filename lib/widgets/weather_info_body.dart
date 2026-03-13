import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_cubit.dart';
import 'package:weather_app/utils/weather_theme.dart';

class WeatherInfoBody extends StatelessWidget {
  const WeatherInfoBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final weatherModel =
    BlocProvider.of<GetWeatherCubit>(context).weatherModel!;

    final bool isNight =
        weatherModel.date.hour >= 18 || weatherModel.date.hour <= 6;

    final gradient = WeatherTheme.getGradient(
      weatherModel.weatherCondition,
      isNight,
      weatherModel.temp,
    );

    return Container(
      decoration: BoxDecoration(gradient: gradient),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              weatherModel.cityName,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'Updated at '
                  '${weatherModel.date.hour.toString().padLeft(2,'0')}:'
                  '${weatherModel.date.minute.toString().padLeft(2,'0')}',
              style: const TextStyle(color: Colors.white70),
            ),

            const SizedBox(height: 16),

            Image.network(
              "https:${weatherModel.image}",
              width: 100,
            ),

            const SizedBox(height: 16),

            Text(
              '${weatherModel.temp.round()}°C',
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 8),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'High: ${weatherModel.maxTemp.round()}°C',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(width: 20),
                Text(
                  'Low: ${weatherModel.minTemp.round()}°C',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Text(
              weatherModel.weatherCondition,
              style: const TextStyle(
                fontSize: 24,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );

  }
}
