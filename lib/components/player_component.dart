import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:gameflamenew/components/kunai_component.dart';
import 'package:gameflamenew/game/main_game.dart';

import '../utils/states.dart';

class PlayerComponent extends SpriteAnimationComponent
    with HasGameRef<MainGame>, CollisionCallbacks {
  //Tamanho Sprite
  final Vector2 playerDimensions = Vector2.all(96);
  final double stepTime = 0.2;
  final double speed = 500;

  late SpriteSheet playerWalkingSpriteSheet;
  late SpriteSheet playerIdleSpriteSheet;
  late SpriteSheet playerJumpSpriteSheet;
  late SpriteSheet playerAttack1SpriteSheet;
  late SpriteSheet playerAttack2SpriteSheet;
  late SpriteSheet playerDeadSpriteSheet;
  late SpriteSheet playerDefendSpriteSheet;

  late SpriteAnimation walkingAnimation =
      playerWalkingSpriteSheet.createAnimation(row: 0, stepTime: stepTime);
  late SpriteAnimation idleAnimation =
      playerIdleSpriteSheet.createAnimation(row: 0, stepTime: stepTime);
  late SpriteAnimation jumpAnimation =
      playerJumpSpriteSheet.createAnimation(row: 0, stepTime: stepTime);
  late SpriteAnimation attack1Animation =
      playerAttack1SpriteSheet.createAnimation(row: 0, stepTime: stepTime);
  late SpriteAnimation attack2Animation =
      playerAttack2SpriteSheet.createAnimation(row: 0, stepTime: stepTime);
  late SpriteAnimation deadAnimation = playerDeadSpriteSheet.createAnimation(
      row: 0, stepTime: stepTime, loop: false);
  late SpriteAnimation defendAnimation =
      playerDefendSpriteSheet.createAnimation(row: 0, stepTime: stepTime);

  StatePlayer current = StatePlayer.idle;

  bool isFacingRight = true;

  int time = 0;
  bool canpress = true;
  bool kunaiPressed = false;

  int lives = 3;
  bool isAlive = true;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    priority = 100;
    anchor = Anchor.center;
    playerWalkingSpriteSheet = SpriteSheet(
      image: await Flame.images.load("Ninja_Monk/Run.png"),
      srcSize: playerDimensions,
    );
    playerIdleSpriteSheet = SpriteSheet(
      image: await Flame.images.load("Ninja_Monk/Idle.png"),
      srcSize: playerDimensions,
    );
    playerJumpSpriteSheet = SpriteSheet(
      image: await Flame.images.load("Ninja_Monk/Jump.png"),
      srcSize: playerDimensions,
    );
    playerAttack1SpriteSheet = SpriteSheet(
      image: await Flame.images.load("Ninja_Monk/Attack_1.png"),
      srcSize: playerDimensions,
    );
    playerAttack2SpriteSheet = SpriteSheet(
      image: await Flame.images.load("Ninja_Monk/Attack_2.png"),
      srcSize: playerDimensions,
    );
    playerDeadSpriteSheet = SpriteSheet(
      image: await Flame.images.load("Ninja_Monk/Dead.png"),
      srcSize: playerDimensions,
    );
    playerDefendSpriteSheet = SpriteSheet(
      image: await Flame.images.load("Ninja_Monk/Hurt.png"),
      srcSize: playerDimensions,
    );
    position = Vector2(gameRef.size.x / 2, gameRef.size.y - 100);
    size = Vector2.all(130);
    add(RectangleHitbox());
    animation = idleAnimation;
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (lives > 0) {
      if (canpress == false) {
        disableKunai();
      }
      if (current == StatePlayer.attack2 || current == StatePlayer.defend) {
        if (animation!.isLastFrame == true) {
          attack2Animation.reset();
          defendAnimation.reset();
          animation = idleAnimation;
          current = StatePlayer.idle;
        }
      } else {
        if (gameRef.joystick.direction == JoystickDirection.idle) {
          current = StatePlayer.idle;
          animation = idleAnimation;
        } else if (gameRef.joystick.direction == JoystickDirection.left) {
          if (isFacingRight) flipHorizontallyAroundCenter();
          x -= 3;
          current = StatePlayer.walk;
          animation = walkingAnimation;
          isFacingRight = false;
        } else if (gameRef.joystick.direction == JoystickDirection.right) {
          if (!isFacingRight) flipHorizontallyAroundCenter();
          x += 3;
          current = StatePlayer.walk;
          animation = walkingAnimation;
          isFacingRight = true;
        }
      }
    } else {
      isAlive = false;
      animation = deadAnimation;
    }
  }

  void disableKunai() {
    time += 1;
    if (time == 100) {
      canpress = true;
      time = 0;
    }
  }

  void playerDeffend() {
    animation = defendAnimation;
    current = StatePlayer.defend;
  }

  void playerAttack2() {
    animation = attack2Animation;
    current = StatePlayer.attack2;
  }

  void playerKunai() {
    if (canpress) {
      gameRef.add(KunaiComponent());
      kunaiPressed = true;
    }
  }
}
