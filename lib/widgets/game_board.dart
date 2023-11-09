import 'package:flutter/material.dart';
import 'package:multiplayer_o_x/provider/room_data_provider.dart';
import 'package:multiplayer_o_x/services/socket_method.dart';
import 'package:provider/provider.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  final SocketMethods _socketMethods = SocketMethods();
  @override
  void initState() {
    super.initState();
    _socketMethods.tappedListener(context);
  }

  void tapped(int index, RoomData roomDataProvider) {
    _socketMethods.gridTapped(index, roomDataProvider.roomData['_id'],
        roomDataProvider.displayElements);
  }

  @override
  Widget build(BuildContext context) {
    final roomProvider = Provider.of<RoomData>(context);
    Size size = MediaQuery.of(context).size;
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: size.height * 0.7, maxWidth: 500),
      child: GridView.builder(
        itemCount: 9,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (context, index) {
          return AbsorbPointer(
            absorbing: roomProvider.roomData['turn']['socketId'] !=
                _socketMethods.socketClient.id,
            child: GestureDetector(
              onTap: () => tapped(index, roomProvider),
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.white24)),
                child: Center(
                  child: AnimatedSize(
                    duration: const Duration(milliseconds: 200),
                    child: Text(
                      roomProvider.displayElements[index],
                      style: TextStyle(
                          fontSize: 100,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                                blurRadius: 40,
                                color:
                                    roomProvider.displayElements[index] == 'O'
                                        ? Colors.red
                                        : Colors.blue)
                          ]),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
