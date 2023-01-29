import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gameflamenew/components/background_component.dart';
import 'package:gameflamenew/components/enemey_component.dart';
import 'package:gameflamenew/components/player_component.dart';
import 'package:gameflamenew/input/joystick.dart';

class MainGame extends FlameGame with HasDraggables, HasTappables {
  PlayerComponent player = PlayerComponent();
  EnemeyComponent enemy = EnemeyComponent();

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
    ]);
    final image = await images.load('Ninja_Monk/joystick.png');
    final sheet = SpriteSheet.fromColumnsAndRows(
      image: image,
      columns: 6,
      rows: 1,
    );
    final sheet2 = SpriteSheet.fromColumnsAndRows(
      image: image,
      columns: 2,
      rows: 1,
    );

    final shapeButton = HudButtonComponent(
      button: CircleComponent(
        radius: 25,
        paint: BasicPalette.lightBlue.paint(),
      ),
      buttonDown: CircleComponent(
        paint: BasicPalette.lightGray.paint(),
        radius: 23,
      ),
      margin: const EdgeInsets.only(
        right: 40,
        bottom: 240,
      ),
      onPressed: () {
        player.playerAttack1();
      },
    );
    final shapeButton3 = HudButtonComponent(
        button: SpriteComponent(
          sprite: sheet.getSpriteById(3),
          size: Vector2.all(80),
        ),
        buttonDown: SpriteComponent(
          sprite: sheet.getSpriteById(5),
          size: Vector2.all(80),
        ),
        margin: const EdgeInsets.only(
          right: 20,
          bottom: 150,
        ),
        onReleased: () {
          player.canpress = false;
        },
        onPressed: () {
          player.playerKunai();
        });
    final shapeButton2 = HudButtonComponent(
      button: SpriteComponent(
        sprite: sheet.getSpriteById(2),
        size: Vector2.all(80),
      ),
      buttonDown: SpriteComponent(
        sprite: sheet.getSpriteById(4),
        size: Vector2.all(80),
      ),
      margin: const EdgeInsets.only(
        right: 100,
        bottom: 150,
      ),
      onReleased: () {
        player.canpress = false;
      },
      onPressed: () {
        player.playerAttack2();
      },
    );
    add(BackgroundComponent());
    add(joystick);
    add(shapeButton);
    add(shapeButton2);
    add(shapeButton3);
    add(player);
    add(enemy);
  }
}