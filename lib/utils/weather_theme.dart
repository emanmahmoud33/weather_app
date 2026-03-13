import 'package:flutter/material.dart';

class WeatherTheme {
  static String getNormalizedCondition(String condition, double temp) {
    final cond = condition.toLowerCase();

    // أبرد حالة
    if (temp <= 0) return "freezing";

    if (cond.contains('rain') || cond.contains('drizzle')) return "rain";
    if (cond.contains('snow')) return "snow";
    if (cond.contains('cloud')) return "cloudy";
    if (cond.contains('thunder')) return "thunder";
    if (cond.contains('sunny') || cond.contains('clear')) return "sunny";

    return "default";
  }

  static LinearGradient getGradient(String condition, bool isNight, double temp) {
    String key = getNormalizedCondition(condition, temp);

    switch (key) {
      case "freezing":
        return const LinearGradient(
          colors: [Color(0xffa1c4fd), Color(0xffc2e9fb)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      case "sunny":
        return isNight
            ? const LinearGradient(
          colors: [Color(0xff0f2027), Color(0xff203a43)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )
            : const LinearGradient(
          colors: [Colors.orange, Colors.yellow],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      case "cloudy":
        return const LinearGradient(
          colors: [Colors.blueGrey, Colors.grey],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      case "rain":
        return const LinearGradient(
          colors: [Colors.indigo, Colors.blueGrey],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      case "snow":
        return const LinearGradient(
          colors: [Colors.lightBlueAccent, Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      case "thunder":
        return const LinearGradient(
          colors: [Colors.deepPurple, Colors.black],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      default:
        return const LinearGradient(
          colors: [Colors.blue, Colors.green],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
    }
  }

  static Color getMainColor(String condition, double temp) {
    String key = getNormalizedCondition(condition, temp);

    switch (key) {
      case "freezing":
        return Colors.lightBlueAccent;
      case "sunny":
        return Colors.orange;
      case "cloudy":
        return Colors.grey;
      case "rain":
        return Colors.blue;
      case "snow":
        return Colors.lightBlue;
      case "thunder":
        return Colors.deepPurple;
      default:
        return Colors.green;
    }
  }
  }
