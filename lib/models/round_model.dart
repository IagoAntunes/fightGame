import 'package:gameflamenew/components/enemy_component.dart';

class RoundModel {
  int quantityEnemies;
  bool isRunning;
  List<EnemyComponent> enemies;
  bool? isLast;
  RoundModel({
    required this.quantityEnemies,
    required this.enemies,
    required this.isRunning,
    this.isLast = false,
  });
}
