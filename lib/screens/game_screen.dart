import 'package:flutter/material.dart';
import 'package:multi_tictactoe/provider/room_data_provider.dart';
import 'package:multi_tictactoe/resources/socket_methods.dart';
import 'package:multi_tictactoe/views/scoreboard.dart';
import 'package:multi_tictactoe/views/tictactoe_board.dart';
import 'package:multi_tictactoe/views/waiting_lobby.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});
  static String route = '/game';

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    _socketMethods.updateRoomListener(context);
    _socketMethods.updatePlayerStats(context);
    _socketMethods.pointIncreaseListener(context);
    _socketMethods.endGameListener(context);
  }

  @override
  Widget build(BuildContext context) {
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);

    return Scaffold(
      body: roomDataProvider.roomData['isJoined']
          ? const WaitingLobby()
          : SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Scoreboard(),
                  const TictactoeBoard(),
                  Text(
                      '${roomDataProvider.roomData['turn']['nickname']}\'s turn'),
                ],
              ),
            ),
    );
  }
}
