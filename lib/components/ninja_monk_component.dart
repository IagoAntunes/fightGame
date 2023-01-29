import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:gameflamenew/components/enemy_component.dart';
import 'package:gameflamenew/components/kunai_component.dart';
import 'package:gameflamenew/components/player_component.dart';
import 'package:gameflamenew/game/main_game.dart';

class NinjaMonkComponent extends EnemyComponent
    with HasGameRef<MainGame>, CollisionCallbacks {
  NinjaMonkComponent({
    required this.isFaceRight,
    this.customPosition = false,
  });

  bool isFaceRight;
  bool customPosition;
  late SpriteSheet enemyIdleSpriteSheet;
  late SpriteSheet enemyRunSpriteSheet;
  late SpriteSheet enemyDeadSpriteSheet;
  late SpriteSheet enemyAttack1SpriteSheet;

  late SpriteAnimation idleAnimation =
      enemyIdleSpriteSheet.createAnimation(row: 0, stepTime: 0.3);
  late SpriteAnimation runAnimation =
      enemyRunSpriteSheet.createAnimation(row: 0, stepTime: 0.3);
  late SpriteAnimation deadAnimation =
      enemyDeadSpriteSheet.createAnimation(row: 0, stepTime: 0.3);

  late SpriteAnimation attack1Animation =
      enemyAttack1SpriteSheet.createAnimation(row: 0, stepTime: 0.3);

  bool isAlive = true;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    enemyIdleSpriteSheet = SpriteSheet(
      image: await Flame.images.load("Kunoichi/Idle.png"),
      srcSize: Vector2.all(128),
    );
    enemyRunSpriteSheet = SpriteSheet(
      image: await Flame.images.load("Kunoichi/Run.png"),
      srcSize: Vector2.all(128),
    );
    enemyAttack1SpriteSheet = SpriteSheet(
      image: await Flame.images.load("Kunoichi/Attack_1.png"),
      srcSize: Vector2.all(130),
    );

    enemyDeadSpriteSheet = SpriteSheet(
      image: await Flame.images.load("Kunoichi/Dead.png"),
      srcSize: Vector2.all(128),
    );
    position = isFaceRight
        ? !customPosition
            ? Vector2(-50, gameRef.size.y - 175)
            : Vector2(-300, gameRef.size.y - 175)
        : !customPosition
            ? Vector2(gameRef.size.x + 60, gameRef.size.y - 175)
            : Vector2(gameRef.size.x + 180, gameRef.size.y - 175);
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
    if (isAlive) {
      animation = runAnimation;
      if (isFaceRight) {
        if ((gameRef.player.position.x - position.x) > 10 &&
            (gameRef.player.position.x - position.x) < 90) {
          if (gameRef.player.isAlive) {
            animation = attack1Animation;
          } else {
            animation = idleAnimation;
          }
          return;
        } else {
          position.x += 2;
          if (position.x >= gameRef.size.x + 60) {
            isFaceRight = false;
            flipHorizontally();
          }
        }
      } else {
        if ((position.x - gameRef.player.position.x) > 10 &&
            (position.x - gameRef.player.position.x) < 90) {
          if (gameRef.player.isAlive) {
            animation = attack1Animation;
          } else {
            animation = idleAnimation;
          }
          return;
        } else {
          position.x -= 2;
          if (position.x <= -60) {
            isFaceRight = true;
            flipHorizontally();
          }
        }
      }
    } else {
      animation = deadAnimation;
      if (animation!.isLastFrame) {
        removeFromParent();
        gameRef.qtdEnemiesAlive--;
      }
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is PlayerComponent && isAlive == true) {
      if ((other.animation == other.attack2Animation)) {
        isAlive = false;
      } else {
        if (animation == attack1Animation &&
            other.animation != other.defendAnimation) {
          if (animation!.currentIndex == 4) {
            other.lives--;
          }
        }
      }
    } else if (other is KunaiComponent && isAlive == true) {
      isAlive = false;
      other.removeFromParent();
    }
  }
}
