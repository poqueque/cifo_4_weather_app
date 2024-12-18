import 'package:flutter/material.dart';
import 'package:weather_app/models/meteo.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:weather_app/widgets/forecast_widget.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Meteo? meteo;

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "WeatherApp",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: (meteo == null)
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: meteo!.dataseries
                  .map(
                    (dataSerie) => ForecastWidget(
                      data: dataSerie,
                      initDateTime: meteo!.initDateTime,
                    ),
                  )
                  .toList(),
            ),
    );
  }

  Future<void> init() async {
    meteo = await WeatherService.instance.fetchDataFromApi();
    setState(() {});
  }
}
