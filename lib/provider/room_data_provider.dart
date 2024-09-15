import 'package:flutter/material.dart';
import 'package:multi_tictactoe/models/players.dart';

class RoomDataProvider extends ChangeNotifier {
  Map<String, dynamic> _roomData = {};
  final List<String> _displayElements = ['', '', '', '', '', '', '', '', ''];
  // ignore: unused_field
  int _filledBoxes = 0;
  Player _player1 =
      Player(nickname: '', socketID: '', points: 0, playerType: 'X');
  Player _player2 =
      Player(nickname: '', socketID: '', points: 0, playerType: 'O');

  Map<String, dynamic> get roomData => _roomData;
  List<String> get displayElements => _displayElements;
  Player get player1 => _player1;
  Player get player2 => _player2;

  void updateRoomData(Map<String, dynamic> data) {
    _roomData = data;
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

  void updateDisplayElements(int index, String choice) {
    print("display element to be updated - Provider");
    _filledBoxes+=1;
    _displayElements[index] = choice;
    notifyListeners();
  }
}
