import 'package:flutter/material.dart';
import 'package:multi_tictactoe/resources/socket_methods.dart';
import 'package:multi_tictactoe/responsive/responsive.dart';
import 'package:multi_tictactoe/widgets/custom_button.dart';
import 'package:multi_tictactoe/widgets/custom_text.dart';
import 'package:multi_tictactoe/widgets/custom_text_field.dart';

class JoinRoomScreen extends StatefulWidget {
  static String route = '/join-room';
  const JoinRoomScreen({super.key});

  @override
  State<JoinRoomScreen> createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends State<JoinRoomScreen> {
  final TextEditingController _namedController = TextEditingController();
  final TextEditingController _gameController = TextEditingController();
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    // TODO: implement initState
    _socketMethods.joinRoomSuccessListener(context);
    _socketMethods.errorOccuredListener(context);
    _socketMethods.updatePlayerStats(context);
    super.initState();
  }

  @override
  void dispose() {
    _namedController.dispose();
    _gameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Responsive(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText(
                shadows: [
                  Shadow(
                    color: Colors.blue,
                    blurRadius: size.width >= 500 ? 16 : 32,
                  ),
                ],
                text: "Join Room",
                FontSize: 70,
              ),
              SizedBox(
                height: size.height * 0.08,
              ),
              CustomTextField(
                controller: _namedController,
                hintText: "Enter your nickname",
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: _gameController,
                hintText: "Enter gameId",
              ),
              SizedBox(
                height: size.height * 0.045,
              ),
              CustomButton(
                  onTap: () {
                    _socketMethods.joinRoom(
                        _namedController.text, _gameController.text);
                  },
                  text: "Join"),
            ],
          ),
        ),
      ),
    );
  }
}
