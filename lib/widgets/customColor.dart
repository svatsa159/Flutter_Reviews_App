import 'package:flutter/material.dart';

class customColor {
  static String reefEncounter = "#079992";
  static String pomegranate = "#C0392B";
  static String forestBlues = "#0A3D62";
  static String waterfallEdited = "#74BEBB";
  static Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }
}
