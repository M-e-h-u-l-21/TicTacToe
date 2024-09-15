import 'package:flutter/material.dart';
import 'package:multi_tictactoe/resources/socket_methods.dart';
import 'package:multi_tictactoe/responsive/responsive.dart';
import 'package:multi_tictactoe/widgets/custom_button.dart';
import 'package:multi_tictactoe/widgets/custom_text.dart';
import 'package:multi_tictactoe/widgets/custom_text_field.dart';

class CreateRoomScreen extends StatefulWidget {
  static String route = '/create-room';
  const CreateRoomScreen({super.key});

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
} 

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  final TextEditingController _namedController = TextEditingController();
  final SocketMethods _scMethods = SocketMethods();

  @override
  void initState() {
    _scMethods.createRoomSuccessListener(context);
    super.initState();
  }

  @override
  void dispose() {
    _namedController.dispose();
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
                text: "Create Room",
                FontSize: 70,
              ),
              SizedBox(
                height: size.height * 0.08,
              ),
              CustomTextField(
                controller: _namedController,
                hintText: "Enter your nickname",
              ),
              SizedBox(
                height: size.height * 0.045,
              ),
              CustomButton(
                  onTap: () {
                    _scMethods.createRoom(
                      _namedController.text.toString(),
                    );
                  },
                  text: "Create"),
            ],
          ),
        ),
      ),
    );
  }
}
