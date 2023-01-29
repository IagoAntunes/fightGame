import 'package:flame/components.dart';
import 'package:gameflamenew/game/main_game.dart';

import '../globals/const.dart';

class BackgroundComponent extends SpriteComponent
    with HasGameRef<MainGame>, Tappable {
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = await gameRef.loadSprite(Globals.backgroundImage);
    size = Vector2(gameRef.size.x, gameRef.size.y);
  }
}
