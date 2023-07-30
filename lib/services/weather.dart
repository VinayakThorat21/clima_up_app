import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';
import 'location.dart';
import 'networking.dart';

class WeatherModel {
  LocationData currentLocation = LocationData();
  NetworkHelper networkHelper = NetworkHelper();
  late double latitude, longitude;

  Future<dynamic> getLocationByCity(String city) async {
    var weatherData = await NetworkHelper().getJsonResponseByCity(city: city);
    return weatherData;
  }

  Future<dynamic> getLocation() async {
    await currentLocation.getLocation();
    latitude = currentLocation.getLatitude();
    longitude = currentLocation.getLongitude();
    var weatherData = await networkHelper.getJsonResponse(
        latitude: latitude, longitude: longitude);
    return weatherData;
  }

  IconData getWeatherIcon(int condition) {
    if (condition < 300) {
      return UniconsLine.thunderstorm;
    } else if (condition < 400) {
      return UniconsLine.raindrops;
    } else if (condition < 600) {
      return UniconsLine.umbrella;
    } else if (condition < 700) {
      return CupertinoIcons.cloud_snow;
    } else if (condition < 800) {
      return UniconsLine.wind;
    } else if (condition == 800) {
      return Icons.wb_sunny_rounded;
    } else if (condition <= 804) {
      return Icons.cloud;
    } else {
      return UniconsLine.confused;
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
