// To parse this JSON data, do
//
//     final meteo = meteoFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

Meteo meteoFromJson(String str) => Meteo.fromJson(json.decode(str));

String meteoToJson(Meteo data) => json.encode(data.toJson());

class Meteo {
  final String product;
  final String init;
  final List<DataSerie> dataseries;

  DateTime get initDateTime => DateTime.parse("${init.substring(0,8)}T${init.substring(8)}0000");

  Meteo({
    required this.product,
    required this.init,
    required this.dataseries,
  });

  factory Meteo.fromJson(Map<String, dynamic> json) => Meteo(
        product: json["product"],
        init: json["init"],
        dataseries: List<DataSerie>.from(
            json["dataseries"].map((x) => DataSerie.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "product": product,
        "init": init,
        "dataseries": List<dynamic>.from(dataseries.map((x) => x.toJson())),
      };
}

class DataSerie {
  final int timepoint;
  final int cloudcover;
  final int liftedIndex;
  final String precType;
  final int precAmount;
  final int temp2M;
  final String rh2M;
  final Wind wind10M;
  final String weather;

  IconData get icon {
    if (precType == "snow") return WeatherIcons.snow;
    if (precType == "rain"){
      if (precAmount <= 3) return WeatherIcons.showers;
      if (precAmount <= 6) return WeatherIcons.rain;
      return WeatherIcons.storm_showers;
    }
    if (precType == "none"){
      if (cloudcover == 0) return WeatherIcons.day_sunny;
      if (cloudcover <= 3) return WeatherIcons.day_cloudy;
      if (cloudcover <= 6) return WeatherIcons.cloud;
      return WeatherIcons.cloudy;
    }
    return WeatherIcons.alien;
  }

  DataSerie({
    required this.timepoint,
    required this.cloudcover,
    required this.liftedIndex,
    required this.precType,
    required this.precAmount,
    required this.temp2M,
    required this.rh2M,
    required this.wind10M,
    required this.weather,
  });

  factory DataSerie.fromJson(Map<String, dynamic> json) => DataSerie(
        timepoint: json["timepoint"],
        cloudcover: json["cloudcover"],
        liftedIndex: json["lifted_index"],
        precType: json["prec_type"],
        precAmount: json["prec_amount"],
        temp2M: json["temp2m"],
        rh2M: json["rh2m"],
        wind10M: Wind.fromJson(json["wind10m"]),
        weather: json["weather"],
      );

  Map<String, dynamic> toJson() => {
        "timepoint": timepoint,
        "cloudcover": cloudcover,
        "lifted_index": liftedIndex,
        "prec_type": precType,
        "prec_amount": precAmount,
        "temp2m": temp2M,
        "rh2m": rh2M,
        "wind10m": wind10M.toJson(),
        "weather": weather,
      };
}

class Wind {
  final String direction;
  final int speed;

  Wind({
    required this.direction,
    required this.speed,
  });

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
        direction: json["direction"],
        speed: json["speed"],
      );

  Map<String, dynamic> toJson() => {
        "direction": direction,
        "speed": speed,
      };
}
