import 'package:weather/common/constants.dart';
import 'package:weather/data/models/weather_response_model.dart';
import 'package:http/http.dart' as http;

class RemoteDataProvider {
  Future<String> getCurrentWeather(double latitude, double longitude) async {
    final url = Uri.parse(
        "http://${Constants.baseUrl}?lat=$latitude&lon=$longitude&units=metric&appid=${Constants.apiKey}");
    final response = await http.get(url);
    print(response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw (e) {
        print(e.toString());
      };
    }
  }

  Future<String> getWeatherData(double latitude, double longitude) async {
    final url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/onecall?lat=$latitude&lon=$longitude&exclude=minutely&units=metric&appid=${Constants.apiKey}");
    final response = await http.get(url);
    print("ONE CALL : ${response.body}");
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw (e) {
        print(e.toString());
      };
    }
  }
}
