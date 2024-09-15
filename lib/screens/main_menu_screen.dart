import 'package:flutter/material.dart';
import 'package:multi_tictactoe/responsive/responsive.dart';
import 'package:multi_tictactoe/screens/create_room_screen.dart';
import 'package:multi_tictactoe/screens/join_room_screen.dart';
import 'package:multi_tictactoe/widgets/custom_button.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});
  static String route = '/main-menu';

  void createRoom(BuildContext context) {
    Navigator.pushNamed(context, CreateRoomScreen.route);
  }

  void joinRoom(BuildContext context) {
    Navigator.pushNamed(context, JoinRoomScreen.route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              onTap: () => createRoom(context),
              text: "Create room",
            ),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
              onTap: () => joinRoom(context),
              text: "Join room", 
            ),
          ],
        ),
      ),
    );
  }
}
