import 'package:flutter/material.dart';
import 'package:multi_tictactoe/provider/room_data_provider.dart';
import 'package:multi_tictactoe/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';

class GameMethods {
  void checkWinner(BuildContext context, Socket socketClient) {
    RoomDataProvider roomDataProvider =
        Provider.of<RoomDataProvider>(context, listen: false);

    String winner = ''; //X or O
    final displayElement = roomDataProvider.displayElements;

    if (displayElement[0] == displayElement[1] &&
        displayElement[1] == displayElement[2] &&
        displayElement[0] != '') {
      winner = displayElement[0];
    }

    if (displayElement[3] == displayElement[4] &&
        displayElement[4] == displayElement[5] &&
        displayElement[3] != '') {
      winner = displayElement[3];
    }

    if (displayElement[6] == displayElement[7] &&
        displayElement[7] == displayElement[8] &&
        displayElement[6] != '') {
      winner = displayElement[6];
    }

    if (displayElement[0] == displayElement[3] &&
        displayElement[3] == displayElement[6] &&
        displayElement[0] != '') {
      winner = displayElement[0];
    }
    if (displayElement[1] == displayElement[4] &&
        displayElement[4] == displayElement[7] &&
        displayElement[1] != '') {
      winner = displayElement[1];
    }
    if (displayElement[2] == displayElement[5] &&
        displayElement[5] == displayElement[8] &&
        displayElement[2] != '') {
      winner = displayElement[2];
    }

    if (displayElement[0] == displayElement[4] &&
        displayElement[4] == displayElement[8] &&
        displayElement[0] != '') {
      winner = displayElement[0];
    }

    if (displayElement[2] == displayElement[4] &&
        displayElement[4] == displayElement[6] &&
        displayElement[2] != '') {
      winner = displayElement[2];
    } else if (roomDataProvider.filledBoxes == 9) {
      winner = '';
      // display dialog saying draw
      showGameDialog(
          context, 'Too bad , you both are just as good. Its a Draw!! ');
    }

    if (winner != '') {
      if (roomDataProvider.player1.playerType == winner) {
        showGameDialog(context, '${roomDataProvider.player1.nickname} won !!');
        socketClient.emit(
          'winner',
          {
            'winnerSocketId': roomDataProvider.player1.socketID,
            'roomId': roomDataProvider.roomData['_id'],
          },
        );
      } else {
        showGameDialog(context, '${roomDataProvider.player2.nickname} won!!');

        socketClient.emit(
          'winner',
          {
            'winnerSocketId': roomDataProvider.player2.socketID,
            'roomId': roomDataProvider.roomData['_id'],
          },
        );
      }
    }
  }

  void clearBoard(BuildContext context) {
    RoomDataProvider roomDataProvider =
        Provider.of<RoomDataProvider>(context, listen: false);
    for (int i = 0; i < roomDataProvider.displayElements.length; i++) {
      roomDataProvider.updateDisplayElements(i, '');
    }
    roomDataProvider.setFilledBoxesTo0();
  }
}
