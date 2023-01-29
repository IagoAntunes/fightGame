import 'package:flutter/material.dart';
import 'package:gameflamenew/overlays/start_screen.dart';

import '../game/main_game.dart';
import '../utils/const.dart';

Widget endScreen(BuildContext context, MainGame game) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    mainAxisSize: MainAxisSize.max,
    children: [
      Center(
        child: GestureDetector(
          onTap: () {
            gameOver = false;
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return const StartScreen();
              },
            ));
          },
          child: const DefaultTextStyle(
            style: TextStyle(
                color: Colors.red, fontSize: 40, fontWeight: FontWeight.w700),
            child: Text('GameOver'),
          ),
        ),
      )
    ],
  );
}
