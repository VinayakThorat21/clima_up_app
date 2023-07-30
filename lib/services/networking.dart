import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:clima_up/utilities/constants.dart';

class NetworkHelper {
  Future getJsonResponseByCity({required String city}) async {
    var url = Uri.https(openWeatherMapWebsite, openWeatherMapPath, {
      'q': city,
      'appid': apiKey,
      'units': 'metric',
    });

    // Get response for an API
    var response = await http.get(url);

    if (response.statusCode == 200) {
      // Request succeeded, parse the response
      var jsonResponse = json.decode(response.body);
      return jsonResponse;
    } else {
      // Request failed, handle the error
      if (kDebugMode) {
        print('Request failed with status code: ${response.statusCode}');
      }
    }
  }

  Future getJsonResponse(
      {required double latitude, required double longitude}) async {
    // Using MaxAI.me
    var url = Uri.https(openWeatherMapWebsite, openWeatherMapPath, {
      'lat': '$latitude',
      'lon': '$longitude',
      'appid': apiKey,
      'units': 'metric',
    });

    // Get response for an API
    var response = await http.get(url);

    if (response.statusCode == 200) {
      // Request succeeded, parse the response
      var jsonResponse = json.decode(response.body);
      return jsonResponse;
    } else {
      // Request failed, handle the error
      if (kDebugMode) {
        print('Request failed with status code: ${response.statusCode}');
      }
    }
  }
}
