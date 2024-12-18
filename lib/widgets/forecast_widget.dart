import 'package:flutter/material.dart';
import 'package:weather_app/models/meteo.dart';

class ForecastWidget extends StatelessWidget {
  const ForecastWidget({
    super.key,
    required this.data,
    required this.initDateTime,
  });

  final DataSerie data;
  final DateTime initDateTime;

  @override
  Widget build(BuildContext context) {
    DateTime timePoint = initDateTime.add(Duration(hours: data.timepoint));

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            "Dia ${timePoint.day}\n${timePoint.hour}:00",
            style: const TextStyle(fontSize: 24),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          flex: 1,
          child: Icon(
            data.icon,
            color: Colors.indigo,
            size: 32,
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            "${data.temp2M} ºC",
            style: const TextStyle(fontSize: 32),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
