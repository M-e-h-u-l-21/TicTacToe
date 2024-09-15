import 'package:flutter/material.dart';
import 'package:multi_tictactoe/provider/room_data_provider.dart';
import 'package:multi_tictactoe/resources/socket_client.dart';
import 'package:multi_tictactoe/screens/game_screen.dart';
import 'package:multi_tictactoe/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketMethods {
  final _socketClient = SocketClient.instance.socket!;

  Socket get socketClient => _socketClient;

  //Emits
  void createRoom(String nickname) {
    // print('Got request');
    if (nickname.isNotEmpty) {
      _socketClient.emit(
        'createRoom',
        {
          'nickname': nickname,
        },
      );
    }
  }

  void joinRoom(String nickname, String roomId) {
    if (nickname.isNotEmpty && roomId.isNotEmpty) {
      _socketClient.emit('joinRoom', {
        'nickname': nickname,
        'roomId': roomId,
      });
    }
  }

  void tapGrid(int index, String roomId, List<String> displayElements) {
    print(displayElements);
    if (displayElements[index] == '') {
      _socketClient.emit('tap', {
        'index': index,
        'roomId': roomId,
      });
    }
  }

  // Listeners
  void createRoomSuccessListener(BuildContext context) {
    _socketClient.on(
      'CreateRoomSuccess',
      (room) {
        Provider.of<RoomDataProvider>(context, listen: false)
            .updateRoomData(room);
        Navigator.pushNamed(context, GameScreen.route);
      },
    );
  }

  void joinRoomSuccessListener(BuildContext context) {
    _socketClient.on(
      'JoinRoomSuccess',
      (room) {
        Provider.of<RoomDataProvider>(context, listen: false)
            .updateRoomData(room);
        Navigator.pushNamed(context, GameScreen.route);
      },
    );
  }

  void errorOccuredListener(BuildContext context) {
    _socketClient.on(
      'errorOccured',
      (data) {
        showSnackBar(context, data.toString());
      },
    );
  }

  void updatePlayerStats(BuildContext context) {
    _socketClient.on('updatePlayers', (playerData) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updatePlayer1(playerData[0]);
      Provider.of<RoomDataProvider>(context, listen: false)
          .updatePlayer2(playerData[1]);
    });
  }

  void updateRoomListener(BuildContext context) {
    _socketClient.on("updateRoom", (room) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(room);
    });
  }

  void onTapListener(BuildContext context) {
    _socketClient.on(
      "tapped",
      (data) {
        print("heard a tap - methods");
        RoomDataProvider roomDataProvider =
            Provider.of<RoomDataProvider>(context, listen: false);
        roomDataProvider.updateDisplayElements(data['index'], data['choice']);
        roomDataProvider.updateRoomData(data['room']);
      },
    );
  }
}
