import 'dart:collection';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:gameflamenew/components/player_component.dart';
import 'package:gameflamenew/game/main_game.dart';

import '../globals/const.dart';
import '../utils/states.dart';

class BackgroundComponent extends SpriteComponent
    with HasGameRef<MainGame>, Tappable {
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    print('LOAD CARREGOU BACK');
    sprite = await gameRef.loadSprite(Globals.backgroundImage);
    size = Vector2(gameRef.size.x, gameRef.size.y);
  }
}
