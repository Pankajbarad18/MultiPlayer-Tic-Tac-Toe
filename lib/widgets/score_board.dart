import 'package:flutter/material.dart';
import 'package:multiplayer_o_x/provider/room_data_provider.dart';
import 'package:multiplayer_o_x/widgets/custom_text.dart';
import 'package:provider/provider.dart';

class ScoreBoard extends StatelessWidget {
  const ScoreBoard({super.key});

  @override
  Widget build(BuildContext context) {
    final roomProvider = Provider.of<RoomData>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                  text: roomProvider.player1.nickname,
                  shadow: const [],
                  fontSize: 20),
              Text(
                roomProvider.player1.points.toInt().toString(),
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText(
                  text: roomProvider.player2.nickname,
                  shadow: const [],
                  fontSize: 20),
              Text(
                roomProvider.player2.points.toInt().toString(),
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
