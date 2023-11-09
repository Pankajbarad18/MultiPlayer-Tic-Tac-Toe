import 'package:flutter/material.dart';
import 'package:multiplayer_o_x/services/socket_method.dart';

import '../responsive/responsive.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text.dart';
import '../widgets/custom_textfield.dart';

class JoinRoom extends StatefulWidget {
  static const String routeName = '/join-room';

  const JoinRoom({super.key});

  @override
  State<JoinRoom> createState() => _JoinRoomState();
}

class _JoinRoomState extends State<JoinRoom> {
  final TextEditingController _roomController = TextEditingController();
  final TextEditingController _gameIdController = TextEditingController();
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    _socketMethods.joinSuccessRoomListener(context);
    _socketMethods.errorOccurredListener(context);
    _socketMethods.updatePlayersStateListener(context);
  }

  @override
  void dispose() {
    super.dispose();
    _roomController.dispose();
    _gameIdController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Responsive(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CustomText(
                  text: 'Join Room',
                  shadow: [Shadow(blurRadius: 5, color: Colors.blue)],
                  fontSize: 72),
              SizedBox(height: size.height * 0.08),
              CustomTextField(
                  controller: _roomController,
                  hintText: 'Enter Your Nickname here'),
              SizedBox(height: size.height * 0.045),
              CustomTextField(
                  controller: _gameIdController, hintText: 'Enter Game ID'),
              SizedBox(height: size.height * 0.045),
              CustomButton(
                  onTap: () => _socketMethods.joinRoom(
                      _roomController.text, _gameIdController.text),
                  text: 'Join')
            ],
          ),
        ),
      ),
    );
  }
}
