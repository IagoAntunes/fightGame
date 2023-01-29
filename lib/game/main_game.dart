import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:gameflamenew/components/background_component.dart';
import 'package:gameflamenew/components/player_component.dart';

import 'round_game.dart';

class MainGame extends FlameGame
    with HasDraggables, HasTappables, HasCollisionDetection {
  late PlayerComponent player;
  late JoystickComponent joystick;
  late RoundGame gameRounds;
  int round = 1;
  int qtdEnemies = 1;
  late int qtdEnemiesAlive;

  int time = 0;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    gameRounds = RoundGame();
    player = PlayerComponent();
    final image = await images.load('Ninja_Monk/joystick.png');
    final sheet = SpriteSheet.fromColumnsAndRows(
      image: image,
      columns: 6,
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
        player.playerDeffend();
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

    joystick = JoystickComponent(
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

    add(BackgroundComponent());
    add(joystick);
    add(shapeButton);
    add(shapeButton2);
    add(shapeButton3);
    add(player);

    qtdEnemiesAlive = qtdEnemies;
  }

  @override
  void update(double dt) async {
    super.update(dt);
    if (gameRounds.currentRound == null) {
      newRound();
    } else {
      if (qtdEnemiesAlive <= 0) {
        if (gameRounds.currentRound!.isLast != true) {
          if (time == 20) {
            time++;
          } else {
            time = 0;
            newRound();
          }
        } else {
          overlays.add("victoryscreen");
        }
      }
      if (!player.isAlive) {
        overlays.add("endscreen");
      }
    }
  }

  void restartGame() {
    time = 0;
    round = 1;
    gameRounds.currentRound = null;
    gameRounds = RoundGame();
    player = PlayerComponent();
  }

  void newRound() {
    switch (round) {
      case 1:
        gameRounds.currentRound = gameRounds.round1;
        break;
      case 2:
        gameRounds.currentRound = gameRounds.round2;
        break;
      case 3:
        gameRounds.currentRound = gameRounds.round3;
        break;
      case 4:
        gameRounds.currentRound = gameRounds.round4;
        break;
      case 5:
        gameRounds.currentRound = gameRounds.round5;
        round = 1;
        break;
    }
    round++;
    qtdEnemies = gameRounds.currentRound!.quantityEnemies;
    qtdEnemiesAlive = gameRounds.currentRound!.quantityEnemies;
    addEnemies();
  }

  void addEnemies() {
    addAll(gameRounds.currentRound!.enemies);
  }
}
