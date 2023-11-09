import 'package:flutter/material.dart';
import 'package:multiplayer_o_x/Screens/game_screen.dart';
import 'package:multiplayer_o_x/provider/room_data_provider.dart';
import 'package:multiplayer_o_x/services/game_winner.dart';
import 'package:multiplayer_o_x/services/socket_client.dart';
import 'package:multiplayer_o_x/utilities/colors.dart';
import 'package:multiplayer_o_x/widgets/custom_snackbar.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketMethods {
  final _socketClient = SocketClient.instance.socket!;
  Socket get socketClient => _socketClient;

  //Emits

  void createRoom(String nickname) {
    if (nickname.isNotEmpty) {
      _socketClient.emit('createRoom', {
        'nickname': nickname,
      });
    }
  }

  void joinRoom(String nickname, String roomId) {
    if (nickname.isNotEmpty && roomId.isNotEmpty) {
      _socketClient.emit('joinRoom', {'nickname': nickname, 'roomId': roomId});
    }
  }

  void gridTapped(int index, String roomId, List<String> displayElements) {
    if (displayElements[index] == '') {
      _socketClient.emit('tap', {
        'index': index,
        'roomId': roomId,
      });
    }
  }

  //Listeners

  void createSuccessRoomListener(BuildContext context) {
    _socketClient.on('roomCreateSuccess', (room) {
      Provider.of<RoomData>(context, listen: false).updateRoomData(room);
      Navigator.pushNamed(context, GameScreen.routeName);
    });
  }

  void joinSuccessRoomListener(BuildContext context) {
    _socketClient.on('joinRoomSuccess', (room) {
      Provider.of<RoomData>(context, listen: false).updateRoomData(room);
      Navigator.pushNamed(context, GameScreen.routeName);
    });
  }

  void errorOccurredListener(BuildContext context) {
    _socketClient.on('errorOccurred', (data) {
      showSnackBar(context, data);
    });
  }

  void updatePlayersStateListener(BuildContext context) {
    _socketClient.on('updatePlayers', (playerData) {
      Provider.of<RoomData>(context, listen: false).updatePlayer1(
        playerData[0],
      );
      Provider.of<RoomData>(context, listen: false).updatePlayer2(
        playerData[1],
      );
    });
  }

  void updateRoomListener(BuildContext context) {
    _socketClient.on('updateRoom', (data) {
      Provider.of<RoomData>(context, listen: false).updateRoomData(data);
    });
  }

  void tappedListener(BuildContext context) {
    _socketClient.on('tapped', (data) {
      RoomData roomDataProvider = Provider.of<RoomData>(context, listen: false);
      roomDataProvider.updateDisplay(
        data['index'],
        data['choice'],
      );
      roomDataProvider.updateRoomData(data['room']);
      GameMethod().checkWinner(context, _socketClient);
    });
  }

  void increasePointListener(BuildContext context) {
    _socketClient.on('increasePoint', (playerdata) {
      RoomData roomDataProvider = Provider.of<RoomData>(context, listen: false);
      if (roomDataProvider.player1.socketId == playerdata['socketId']) {
        roomDataProvider.updatePlayer1(playerdata);
      } else {
        roomDataProvider.updatePlayer2(playerdata);
      }
    });
  }

  void endGame(BuildContext context) {
    _socketClient.on('endGame', (playerdata) {
      showGameDialoge(context, '${playerdata['nickname']} Won the Game');
      Navigator.popUntil(context, (route) => false);
    });
  }
}
