import 'package:flutter/material.dart';
import 'package:multi_tictactoe/provider/room_data_provider.dart';
import 'package:multi_tictactoe/screens/create_room_screen.dart';
import 'package:multi_tictactoe/screens/game_screen.dart';
import 'package:multi_tictactoe/screens/join_room_screen.dart';
import 'package:multi_tictactoe/screens/main_menu_screen.dart';
import 'package:multi_tictactoe/utils/colors.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RoomDataProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: bgColor,
          useMaterial3: false,
        ),
        routes: {
          MainMenuScreen.route: (context) => const MainMenuScreen(),
          JoinRoomScreen.route: (context) => const JoinRoomScreen(),
          CreateRoomScreen.route: (context) => const CreateRoomScreen(),
          GameScreen.route: (context) => const GameScreen(),
        },
        initialRoute: MainMenuScreen.route,
        home: const MainMenuScreen(),
      ),
    );
  }
}
