import 'package:weather/services/location.dart';
import 'package:weather/services/networking.dart';
import 'package:weather/secrets.dart';

const openWeatherAppURL = "https://api.openweathermap.org/data/2.5/weather";

class WeatherModel {
  static Future<Map> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        url:
            "$openWeatherAppURL?lat=${location.latitude}&lon=${location.longitude}&appid=$openWeatherApiKey&units=imperial");
    Map weatherData = await networkHelper.getData();

    return weatherData;
  }

  static Future<Map> getCityWeather(String cityName) async {
    Location location = Location();
    String url =
        '$openWeatherAppURL?q=$cityName&appid=$openWeatherApiKey&units=imperial';
    NetworkHelper networkHelper = NetworkHelper(url: url);
    Map weatherData = await networkHelper.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '๐ฉ';
    } else if (condition < 400) {
      return '๐ง';
    } else if (condition < 600) {
      return 'โ๏ธ';
    } else if (condition < 700) {
      return 'โ๏ธ';
    } else if (condition < 800) {
      return '๐ซ';
    } else if (condition == 800) {
      return 'โ๏ธ';
    } else if (condition <= 804) {
      return 'โ๏ธ';
    } else {
      return '๐คทโ';
    }
  }

  String getMessage(int temp) {
    if (temp > 77) {
      return 'It\'s ๐ฆ time';
    } else if (temp > 68) {
      return 'Time for shorts and ๐';
    } else if (temp < 50) {
      return 'You\'ll need ๐งฃ and ๐งค';
    } else {
      return 'Bring a ๐งฅ just in case';
    }
  }
}
