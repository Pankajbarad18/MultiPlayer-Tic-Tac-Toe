import 'package:flutter/material.dart';
import 'package:multiplayer_o_x/models/player.dart';

class RoomData extends ChangeNotifier {
  Map<String, dynamic> _roomdata = {};
  Player _player1 = Player(
    nickname: '',
    socketId: '',
    points: 0,
    playerType: 'X',
  );

  Player _player2 = Player(
    nickname: '',
    socketId: '',
    points: 0,
    playerType: 'O',
  );

  List<String> _displayElements = ['', '', '', '', '', '', '', '', ''];
  int _filledBox = 0;
  Map<String, dynamic> get roomData => _roomdata;

  Player get player1 => _player1;
  Player get player2 => _player2;

  List<String> get displayElements => _displayElements;
  int get filledBox => _filledBox;

  void updateRoomData(Map<String, dynamic> data) {
    _roomdata = data;
    notifyListeners();
  }

  void updatePlayer1(Map<String, dynamic> player1Data) {
    _player1 = Player.fromMap(player1Data);
    notifyListeners();
  }

  void updatePlayer2(Map<String, dynamic> player2Data) {
    _player2 = Player.fromMap(player2Data);
    notifyListeners();
  }

  void updateDisplay(int index, String choice) {
    displayElements[index] = choice;
    _filledBox += 1;
    notifyListeners();
  }

  void clearFilled() {
    _filledBox = 0;
  }
}
