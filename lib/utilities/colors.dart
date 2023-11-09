import 'package:flutter/material.dart';
import 'package:multiplayer_o_x/services/game_winner.dart';

const Color bgColor = Color.fromRGBO(13, 16, 34, 1);

void showGameDialoge(BuildContext context, String text) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(text),
          actions: [
            TextButton(
                onPressed: () {
                  GameMethod().PlayAgain(context);
                  Navigator.pop(context);
                },
                child: const Text('Play Again'))
          ],
        );
      });
}
