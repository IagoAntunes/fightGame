import 'package:flame/game.dart';
import 'package:gameflamenew/components/background_component.dart';

class MainGame extends FlameGame with HasDraggables {
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    add(BackgroundComponent());
  }
}
