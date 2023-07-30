import 'package:flutter/material.dart';
import 'package:clima_up/utilities/constants.dart';
import 'package:clima_up/services/weather.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key, @required this.weatherData});
  final dynamic weatherData;
  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  dynamic temperature, city, activity;
  late IconData weatherIcon;
  WeatherModel weatherModel = WeatherModel();

  @override
  void initState() {
    super.initState();
    updateUI(widget.weatherData);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      // weatherData = null; // results in app crash
      if (weatherData == null) {
        temperature = 0;
        city = 'fetching data';
        weatherIcon = weatherModel.getWeatherIcon(805);
        activity = 'There was a problem';
        return;
      }
      double temp = weatherData['main']['temp'];
      var condition = weatherData['weather'][0]['id'];

      temperature = temp.round();
      city = weatherData['name'];
      weatherIcon = weatherModel.getWeatherIcon(condition);
      activity = weatherModel.getMessage(temperature);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // Get weather of current location
                  TextButton(
                    onPressed: () async {
                      var weatherData = await weatherModel.getLocation();
                      updateUI(weatherData);
                    },
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),

                  // Get weather of custom location
                  TextButton(
                    onPressed: () async {
                      // Receive data from last screen, in case it was pop offed
                      dynamic city = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CityScreen(),
                        ),
                      );

                      if (city != null) {
                        var weatherData = await WeatherModel()
                            .getLocationByCity(city as String);
                        updateUI(weatherData);
                      }
                    },
                    child: const Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°C',
                      style: kTempTextStyle,
                    ),
                    const SizedBox(
                      width: 30.0,
                    ),
                    Icon(
                      weatherIcon,
                      color: Colors.blue,
                      size: 100.0,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Text(
                  "$activity in $city!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
