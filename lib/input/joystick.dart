import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/cupertino.dart';

JoystickComponent joystick = JoystickComponent(
  knob: CircleComponent(
    radius: 15,
    paint: BasicPalette.red.withAlpha(100).paint(),
  ),
  background: CircleComponent(
    radius: 50,
    paint: BasicPalette.red.withAlpha(50).paint(),
  ),
  margin: const EdgeInsets.only(
    left: 20,
    bottom: 20,
  ),
);
