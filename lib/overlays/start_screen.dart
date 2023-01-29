import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:gameflamenew/overlays/victory_screen.dart';

import '../game/main_game.dart';
import 'end_screen.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/back/City2/Bright/City2.png'),
                fit: BoxFit.fill)),
        child: Center(
          child: GestureDetector(
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return GameWidget(
                    game: MainGame(),
                    overlayBuilderMap: const {
                      "endscreen": endScreen,
                      "victoryscreen": victoryscreen
                    },
                  );
                },
              ));
            },
            child: const Text(
              'Começar',
              style: TextStyle(
                color: Colors.white,
                fontSize: 42,
                fontWeight: FontWeight.w700,
                letterSpacing: 4,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
