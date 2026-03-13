import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/get_weather_cubit/get_weather_cubit.dart';
import '../cubits/get_weather_cubit/get_weather_state.dart';
import 'home_view.dart';
import '../utils/weather_theme.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool hasNavigated = false; // عشان نمنع النقل أكتر من مرة

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    _animation = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // جلب الطقس أول مرة
      BlocProvider.of<GetWeatherCubit>(context).getWeather(cityName: 'mansoura');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetWeatherCubit, WeatherState>(
      listener: (context, state) {
        if (state is WeatherLoadedState && !hasNavigated) {
          hasNavigated = true; // منع النقل أكثر من مرة

          // تأخير بسيط قبل الانتقال عشان الـ animation يبان
          Future.delayed(const Duration(milliseconds: 800), () {
            if (mounted) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const HomeView()),
              );
            }
          });
        }
      },
      builder: (context, state) {
        LinearGradient gradient = const LinearGradient(
          colors: [Colors.transparent, Colors.transparent],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );

        if (state is WeatherLoadedState) {
          final model = state.weatherModel;
          final bool isNight =
              model.date.hour >= 18 || model.date.hour <= 6;

          gradient = WeatherTheme.getGradient(
            model.weatherCondition,
            isNight,
            model.temp,
          );
        }

        return Container(
          decoration: BoxDecoration(gradient: gradient),
          child: Center(
            child: ScaleTransition(
              scale: _animation,
              child: Image.asset(
                'assets/images/logo.png',
                width: 120,
              ),
            ),
          ),
        );
      },
    );
  }
}
