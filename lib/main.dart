import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gameflamenew/overlays/start_screen.dart';

void main() {
  WidgetsFlutterBinding();
  Flame.device.fullScreen();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
  ]);
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StartScreen(),
    ),
  );
}
