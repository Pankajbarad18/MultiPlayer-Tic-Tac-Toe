import 'package:flutter/material.dart';
import 'package:multiplayer_o_x/provider/room_data_provider.dart';
import 'package:multiplayer_o_x/utilities/colors.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';

class GameMethod {
  void checkWinner(BuildContext context, Socket socketClient) {
    RoomData roomDataProvider = Provider.of<RoomData>(context, listen: false);
    String winner = '';

    //For Row
    //0 1 2
    if (roomDataProvider.displayElements[0] != '' &&
        roomDataProvider.displayElements[0] ==
            roomDataProvider.displayElements[1] &&
        roomDataProvider.displayElements[0] ==
            roomDataProvider.displayElements[2]) {
      winner = roomDataProvider.displayElements[0];
    } else
    //3 4 5
    if (roomDataProvider.displayElements[3] != '' &&
        roomDataProvider.displayElements[3] ==
            roomDataProvider.displayElements[4] &&
        roomDataProvider.displayElements[3] ==
            roomDataProvider.displayElements[5]) {
      winner = roomDataProvider.displayElements[3];
    } else
    //6 7 8
    if (roomDataProvider.displayElements[6] != '' &&
        roomDataProvider.displayElements[6] ==
            roomDataProvider.displayElements[7] &&
        roomDataProvider.displayElements[6] ==
            roomDataProvider.displayElements[8]) {
      winner = roomDataProvider.displayElements[6];
    }

    //For Column
    else
    //0 3 6
    if (roomDataProvider.displayElements[0] != '' &&
        roomDataProvider.displayElements[0] ==
            roomDataProvider.displayElements[3] &&
        roomDataProvider.displayElements[0] ==
            roomDataProvider.displayElements[6]) {
      winner = roomDataProvider.displayElements[0];
    } else
    //1 4 7
    if (roomDataProvider.displayElements[1] != '' &&
        roomDataProvider.displayElements[1] ==
            roomDataProvider.displayElements[4] &&
        roomDataProvider.displayElements[1] ==
            roomDataProvider.displayElements[7]) {
      winner = roomDataProvider.displayElements[1];
    } else
    //2 5 8
    if (roomDataProvider.displayElements[2] != '' &&
        roomDataProvider.displayElements[2] ==
            roomDataProvider.displayElements[5] &&
        roomDataProvider.displayElements[2] ==
            roomDataProvider.displayElements[8]) {
      winner = roomDataProvider.displayElements[2];
    }

    //For Diagonal
    else
    //0 4 8
    if (roomDataProvider.displayElements[0] != '' &&
        roomDataProvider.displayElements[0] ==
            roomDataProvider.displayElements[4] &&
        roomDataProvider.displayElements[0] ==
            roomDataProvider.displayElements[8]) {
      winner = roomDataProvider.displayElements[0];
    } else
    //2 4 6
    if (roomDataProvider.displayElements[2] != '' &&
        roomDataProvider.displayElements[2] ==
            roomDataProvider.displayElements[4] &&
        roomDataProvider.displayElements[2] ==
            roomDataProvider.displayElements[6]) {
      winner = roomDataProvider.displayElements[2];
    } else if (roomDataProvider.filledBox == 9) {
      winner = '';
      showGameDialoge(context, 'Game Draw');
    }

    if (winner != '') {
      if (winner == roomDataProvider.player1.playerType) {
        showGameDialoge(
            context, '${roomDataProvider.player1.nickname} Won The Game');
        socketClient.emit('winner', {
          'winnerSocketId': roomDataProvider.player1.socketId,
          'roomId': roomDataProvider.roomData['_id']
        });
      } else {
        showGameDialoge(
            context, '${roomDataProvider.player2.nickname} Won The Game');
        socketClient.emit('winner', {
          'winnerSocketId': roomDataProvider.player2.socketId,
          'roomId': roomDataProvider.roomData['_id']
        });
      }
    }
  }

  void PlayAgain(BuildContext context) {
    RoomData roomDataProvider = Provider.of<RoomData>(context, listen: false);
    for (int i = 0; i < roomDataProvider.displayElements.length; i++) {
      roomDataProvider.updateDisplay(i, '');
    }
    roomDataProvider.clearFilled();
  }
}
