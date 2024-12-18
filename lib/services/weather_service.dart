import 'package:http/http.dart' as http;
import 'package:weather_app/models/meteo.dart';

class WeatherService {
  static final WeatherService instance = WeatherService._internal();
  WeatherService._internal();

  static const double lat = 41.35967;
  static const double lon = 2.10028;

  final url =
      "https://www.7timer.info/bin/civil.php?lon=$lon&lat=$lat&ac=0&unit=metric&output=json";

  Future<Meteo> fetchDataFromApi() async {
    http.Response response = await http.get(Uri.parse(url));
    final Meteo meteo = meteoFromJson(response.body);
    return meteo;
  }
}
