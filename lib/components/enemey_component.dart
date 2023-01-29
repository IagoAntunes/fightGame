import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:gameflamenew/game/main_game.dart';

class EnemeyComponent extends SpriteAnimationComponent
    with HasGameRef<MainGame> {
  late SpriteSheet enemyIdleSpriteSheet;

  late SpriteAnimation idleAnimation =
      enemyIdleSpriteSheet.createAnimation(row: 0, stepTime: 0.3);

  @override
  Future<void> onLoad() async {
    super.onLoad();

    enemyIdleSpriteSheet = SpriteSheet(
      image: await Flame.images.load("Kunoichi/Idle.png"),
      srcSize: Vector2.all(128),
    );
    position = Vector2(gameRef.size.x / 2, gameRef.size.y - 100);
    size = Vector2.all(100);
    animation = idleAnimation;
  }
}
