import 'package:flutter/material.dart';
import 'package:multi_tictactoe/provider/room_data_provider.dart';
import 'package:multi_tictactoe/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class WaitingLobby extends StatefulWidget {
  const WaitingLobby({super.key});

  @override
  State<WaitingLobby> createState() => _WaitingLobbyState();
}

class _WaitingLobbyState extends State<WaitingLobby> {
  late final TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController(
        text: Provider.of<RoomDataProvider>(context, listen: false)
            .roomData['token']
            .toString());
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Waiting for your friend to join..."),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomTextField(
            controller: controller,
            hintText: '',
            isReadOnly: true,
          ),
        ),
      ],
    );
  }
}
