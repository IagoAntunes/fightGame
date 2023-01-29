import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:gameflamenew/game/main_game.dart';

class KunaiComponent extends SpriteAnimationComponent
    with HasGameRef<MainGame>, CollisionCallbacks {
  final Vector2 playerDimensions = Vector2.all(15);
  late SpriteSheet kunaiSpriteSheet;
  late SpriteAnimation kunaiAnimation =
      kunaiSpriteSheet.createAnimation(row: 0, stepTime: 0.2);

  late bool isPlayerFacingRight;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    kunaiSpriteSheet = SpriteSheet(
      image: await Flame.images.load("Ninja_Monk/Kunai.png"),
      srcSize: playerDimensions,
    );
    add(CircleHitbox.relative(0.3, parentSize: Vector2.all(30)));
    position = gameRef.player.position;
    animation = kunaiAnimation;
    size = Vector2.all(35);
    isPlayerFacingRight = gameRef.player.isFacingRight;
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (position.x < -50 || position.x > gameRef.size.x + 50) {
      removeFromParent();
    }
    if (isPlayerFacingRight) {
      position.x += 2;
    } else {
      position.x -= 2;
    }
  }
}
