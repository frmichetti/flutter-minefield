import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/minefield_app.dart';

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MineFieldApp());
}
