import 'package:flutter/material.dart';
import 'package:multiplayer_o_x/services/socket_method.dart';
import 'package:multiplayer_o_x/widgets/game_board.dart';
import 'package:multiplayer_o_x/widgets/score_board.dart';
import 'package:multiplayer_o_x/widgets/waiting_lobby.dart';
import 'package:provider/provider.dart';

import '../provider/room_data_provider.dart';

class GameScreen extends StatefulWidget {
  static const String routeName = '/game-screen';
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    _socketMethods.updateRoomListener(context);
    _socketMethods.updatePlayersStateListener(context);
    _socketMethods.increasePointListener(context);
    _socketMethods.endGame(context);
  }

  @override
  Widget build(BuildContext context) {
    RoomData roomDataProvider = Provider.of<RoomData>(context);
    return Scaffold(
      body: roomDataProvider.roomData['isJoin']
          ? const WaitingLobby()
          : SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const ScoreBoard(),
                  const GameBoard(),
                  Text(
                      '${roomDataProvider.roomData['turn']['nickname']}\'s turn'),
                ],
              ),
            ),
    );
  }
}
