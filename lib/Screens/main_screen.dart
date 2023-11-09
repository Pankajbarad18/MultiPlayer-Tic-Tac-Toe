import 'package:flutter/material.dart';
import 'package:multiplayer_o_x/Screens/create_room.dart';
import 'package:multiplayer_o_x/Screens/join_room.dart';
import 'package:multiplayer_o_x/responsive/responsive.dart';
import 'package:multiplayer_o_x/widgets/custom_button.dart';

class MainScreen extends StatelessWidget {
  static const String routeName = '/main-screen';
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    navigateToCreateRoom() {
      Navigator.pushNamed(context, CreateRoom.routeName);
    }

    navigateToJoinRoom() {
      Navigator.pushNamed(context, JoinRoom.routeName);
    }

    return Scaffold(
        body: Responsive(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomButton(onTap: navigateToCreateRoom, text: 'Create Room'),
          const SizedBox(height: 20),
          CustomButton(onTap: navigateToJoinRoom, text: 'Join Room')
        ],
      ),
    ));
  }
}
