class WeatherModel {
  final String cityName;
  final DateTime date;
  final String? image;
  final double temp;
  final double maxTemp;
  final double minTemp;
  final String weatherCondition;

  WeatherModel({
    required this.cityName,
    required this.date,
    required this.image,
    required this.temp,
    required this.maxTemp,
    required this.minTemp,
    required this.weatherCondition,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    // قراءة forecast اليوم الأول
    final forecastDay = json['forecast']['forecastday'][0]['day'];
    final condition = forecastDay['condition'];

    // تحويل القيم بشكل آمن
    double parseDouble(dynamic value) {
      if (value == null) return 0.0;
      return double.tryParse(value.toString()) ?? 0.0;
    }

    // تحويل التاريخ من String إلى DateTime
    DateTime parseEpoch(dynamic epoch) {
      if (epoch == null) return DateTime.now();
      return DateTime.fromMillisecondsSinceEpoch(epoch * 1000);
    }

    return WeatherModel(
      cityName: json['location']['name']?.toString() ?? '',
      date: parseEpoch(json['location']['localtime_epoch']),
      image: condition['icon']?.toString(),
      temp: parseDouble(forecastDay['avgtemp_c']),
      maxTemp: parseDouble(forecastDay['maxtemp_c']),
      minTemp: parseDouble(forecastDay['mintemp_c']),
      weatherCondition: condition['text']?.toString() ?? '',
    );
  }
}
