import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:gameflamenew/components/kunai_component.dart';
import 'package:gameflamenew/game/main_game.dart';

import '../input/joystick.dart';
import '../utils/states.dart';

class PlayerComponent extends SpriteAnimationComponent
    with HasGameRef<MainGame> {
  //Tamanho Sprite
  final Vector2 playerDimensions = Vector2.all(96);
  final double stepTime = 0.2;
  final double speed = 500;

  late SpriteSheet playerWalkingSpriteSheet;
  late SpriteSheet playerIdleSpriteSheet;
  late SpriteSheet playerJumpSpriteSheet;
  late SpriteSheet playerAttack1SpriteSheet;
  late SpriteSheet playerAttack2SpriteSheet;

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
  StatePlayer current = StatePlayer.idle;
  bool isFacingRight = true;

  int time = 0;
  bool canpress = true;
  bool kunaiPressed = false;

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
    position = Vector2(gameRef.size.x / 2, gameRef.size.y - 100);
    size = Vector2.all(100);
    animation = idleAnimation;
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (canpress == false) {
      disableKunai();
    }
    if (current == StatePlayer.attack1 || current == StatePlayer.attack2) {
      if (animation!.isLastFrame == true) {
        attack1Animation.reset();
        attack2Animation.reset();
        animation = idleAnimation;
        current = StatePlayer.idle;
      }
    } else {
      if (joystick.direction == JoystickDirection.idle) {
        current = StatePlayer.idle;
        animation = idleAnimation;
      } else if (joystick.direction == JoystickDirection.left) {
        if (isFacingRight) flipHorizontallyAroundCenter();
        x -= 3;
        current = StatePlayer.walk;
        animation = walkingAnimation;
        isFacingRight = false;
      } else if (joystick.direction == JoystickDirection.right) {
        if (!isFacingRight) flipHorizontallyAroundCenter();
        x += 3;
        current = StatePlayer.walk;
        animation = walkingAnimation;
        isFacingRight = true;
      } else if (joystick.direction == JoystickDirection.up) {
        // if (!isFacingRight) flipHorizontallyAroundCenter();
        // y -= 3;
        // current = StatePlayer.walk;
        // animation = jumpAnimation;
      }
    }

    bool movingLeft = joystick.relativeDelta[0] < 0;
  }

  void disableKunai() {
    time += 1;
    if (time == 100) {
      canpress = true;
      time = 0;
    }
  }

  void playerAttack1() {
    animation = attack1Animation;
    current = StatePlayer.attack1;
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
