import 'package:gameflamenew/components/ninja_monk_component.dart';
import 'package:gameflamenew/components/ninja_peasant_component.dart';
import 'package:gameflamenew/models/round_model.dart';

class RoundGame {
  RoundModel? currentRound;

  var round1 = RoundModel(
    quantityEnemies: 1,
    enemies: [
      NinjaMonkComponent(
        isFaceRight: true,
      ),
    ],
    isRunning: false,
  );

  var round2 = RoundModel(
    quantityEnemies: 1,
    enemies: [
      NinjaMonkComponent(
        isFaceRight: false,
      ),
    ],
    isRunning: false,
  );

  var round3 = RoundModel(
    quantityEnemies: 2,
    enemies: [
      NinjaMonkComponent(
        isFaceRight: true,
      ),
      NinjaMonkComponent(
        isFaceRight: false,
      ),
    ],
    isRunning: false,
  );

  var round4 = RoundModel(
    quantityEnemies: 4,
    enemies: [
      NinjaMonkComponent(
        isFaceRight: true,
      ),
      NinjaMonkComponent(
        isFaceRight: true,
        customPosition: true,
      ),
      NinjaMonkComponent(
        isFaceRight: false,
        customPosition: true,
      ),
      NinjaMonkComponent(
        isFaceRight: false,
      ),
    ],
    isRunning: false,
  );
  var round5 = RoundModel(
    isLast: true,
    quantityEnemies: 2,
    enemies: [
      NinjaPeasant(
        isFaceRight: true,
      ),
      NinjaPeasant(
        isFaceRight: false,
      ),
    ],
    isRunning: false,
  );
}
