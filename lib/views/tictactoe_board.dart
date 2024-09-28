import 'package:flutter/material.dart';
import 'package:multi_tictactoe/provider/room_data_provider.dart';
import 'package:multi_tictactoe/resources/socket_methods.dart';
import 'package:provider/provider.dart';

class TictactoeBoard extends StatefulWidget {
  const TictactoeBoard({super.key});

  @override
  _TictactoeBoardState createState() => _TictactoeBoardState();
}

class _TictactoeBoardState extends State<TictactoeBoard> {
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    _socketMethods.onTapListener(context);
  }

  // void tapped(int index, RoomDataProvider roomDataProvider) {
  //   print("Tapped");
  //   _socketMethods.tapGrid(
  //     index,
  //     roomDataProvider.roomData['_id'],
  //     roomDataProvider.displayElements,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);

    final size = MediaQuery.of(context).size;

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: size.height * 0.7,
        maxWidth: 500,
      ),
      child: AbsorbPointer(
        // Used to restrict turn according to the valid user only
        absorbing: roomDataProvider.roomData['turn']['socketID'] !=
            _socketMethods.socketClient.id,

        child: GridView.builder(
          itemCount: 9,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // print(roomDataProvider.displayElements);
                _socketMethods.tapGrid(
                  index,
                  roomDataProvider.roomData['token'].toString(),
                  roomDataProvider.displayElements,
                );
                print("Tapped");
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white24,
                  ),
                ),
                child: Center(
                  child: AnimatedSize(
                    duration: const Duration(milliseconds: 200),
                    child: Text(
                      roomDataProvider.displayElements[index],
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 100,
                        shadows: [
                          Shadow(
                            blurRadius: 40,
                            color:
                                roomDataProvider.displayElements[index] == 'O'
                                    ? Colors.red
                                    : Colors.blue,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
