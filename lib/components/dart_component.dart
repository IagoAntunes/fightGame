import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:gameflamenew/components/player_component.dart';
import 'package:gameflamenew/game/main_game.dart';

class DartComponent extends SpriteComponent
    with HasGameRef<MainGame>, CollisionCallbacks {
  late Vector2 positionEnemy;
  late bool isFaceRight;
  DartComponent({
    required this.positionEnemy,
    required this.isFaceRight,
  });
  @override
  Future<void> onLoad() async {
    super.onLoad();

    sprite = await gameRef.loadSprite("Ninja_Peasant/Dart.png");
    size = Vector2.all(15);
    position = positionEnemy;
    add(CircleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    isFaceRight ? position.x += 3 : position.x -= 3;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is PlayerComponent && other.isAlive) {
      if (other.animation == other.attack1Animation ||
          other.animation == other.defendAnimation) {
        removeFromParent();
      } else {
        other.lives -= 2;
        removeFromParent();
      }
    }
  }
}
