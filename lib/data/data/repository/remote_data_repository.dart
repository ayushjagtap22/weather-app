import 'dart:convert';

import 'package:weather/data/data/data_provider/remote_data_provider.dart';
import 'package:weather/data/models/one_call_model.dart';
import 'package:weather/data/models/weather_response_model.dart';

class RemoteDataRepository {
  final RemoteDataProvider remoteDataProvider;

  RemoteDataRepository({required this.remoteDataProvider});

  Future<CurrentWeatherResponse> getCurrentWeather(
      double latitude, double longitude) async {
    final response =
        await remoteDataProvider.getCurrentWeather(latitude, longitude);
    final decodedResponse = jsonDecode(response);
    final map = CurrentWeatherResponse.fromJson(decodedResponse);

    return map;
  }

  Future<OneCallModel> getAllWeatherData(
      double latitude, double longitude) async {
    final response =
        await remoteDataProvider.getWeatherData(latitude, longitude);
    final decodedResponse = jsonDecode(response);
    final map = OneCallModel.fromJson(decodedResponse);
    return map;
  }
}
