import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:gameflamenew/components/dart_component.dart';
import 'package:gameflamenew/components/enemy_component.dart';
import 'package:gameflamenew/components/kunai_component.dart';
import 'package:gameflamenew/components/player_component.dart';
import 'package:gameflamenew/game/main_game.dart';

class NinjaPeasant extends EnemyComponent
    with HasGameRef<MainGame>, CollisionCallbacks {
  NinjaPeasant({
    required this.isFaceRight,
  });

  bool isFaceRight = true;

  late SpriteSheet idleEnemySpritesheet;
  late SpriteSheet deadEnemySpriteSheet;

  late SpriteAnimation idleEnemyAnimation =
      idleEnemySpritesheet.createAnimation(row: 0, stepTime: 0.3);
  late SpriteAnimation deadEnemyAnimation =
      deadEnemySpriteSheet.createAnimation(
    row: 0,
    stepTime: 0.3,
    loop: false,
  );

  int time = 1;
  bool isAlive = true;
  @override
  Future<void> onLoad() async {
    super.onLoad();

    idleEnemySpritesheet = SpriteSheet(
      image: await Flame.images.load("Ninja_Peasant/Idle.png"),
      srcSize: Vector2.all(96),
    );
    deadEnemySpriteSheet = SpriteSheet(
      image: await Flame.images.load("Ninja_Peasant/Dead.png"),
      srcSize: Vector2.all(96),
    );
    position = isFaceRight
        ? Vector2(20, gameRef.size.y - 170)
        : Vector2(gameRef.size.x - 40, gameRef.size.y - 170);
    size = Vector2.all(130);
    add(RectangleHitbox());
    animation = idleEnemyAnimation;
    if (!isFaceRight) {
      flipHorizontally();
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (isAlive) {
      time++;
      if (time % 200 == 0) {
        gameRef.add(
          DartComponent(
            positionEnemy: isFaceRight
                ? Vector2(position.x + 50, position.y + 60)
                : Vector2(position.x - 60, position.y + 60),
            isFaceRight: isFaceRight,
          ),
        );
      }
    } else {
      if (animation!.isLastFrame) {
        removeFromParent();
        gameRef.qtdEnemiesAlive--;
      }
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is PlayerComponent && other.isAlive) {
      if (other.animation == other.attack2Animation) {
        isAlive = false;
        animation = deadEnemyAnimation;
      }
    } else if (other is KunaiComponent) {
      isAlive = false;
      animation = deadEnemyAnimation;
    }
  }
}
