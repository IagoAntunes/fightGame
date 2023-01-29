import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:gameflamenew/game/main_game.dart';

class EnemeyComponent extends SpriteAnimationComponent
    with HasGameRef<MainGame>, CollisionCallbacks {
  EnemeyComponent({
    required this.positionEnemy,
    required this.isFaceRight,
  });

  Vector2 positionEnemy;
  bool isFaceRight;

  late SpriteSheet enemyIdleSpriteSheet;
  late SpriteSheet enemyRunSpriteSheet;
  late SpriteAnimation idleAnimation =
      enemyIdleSpriteSheet.createAnimation(row: 0, stepTime: 0.3);
  late SpriteAnimation runAnimation =
      enemyRunSpriteSheet.createAnimation(row: 0, stepTime: 0.3);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    enemyIdleSpriteSheet = SpriteSheet(
      image: await Flame.images.load("Kunoichi/Idle.png"),
      srcSize: Vector2.all(128),
    );
    enemyRunSpriteSheet = SpriteSheet(
        image: await Flame.images.load("Kunoichi/Run.png"),
        srcSize: Vector2.all(128));
    position = positionEnemy;
    add(RectangleHitbox());
    size = Vector2.all(140);
    animation = idleAnimation;
    if (!isFaceRight) {
      flipHorizontally();
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    animation = runAnimation;
    if (isFaceRight) {
      position.x += 2;
      if (position.x >= gameRef.size.x + 60) {
        isFaceRight = false;
        flipHorizontally();
      }
    } else {
      position.x -= 2;
      if (position.x <= -60) {
        isFaceRight = true;
        flipHorizontally();
      }
    }
  }
}
