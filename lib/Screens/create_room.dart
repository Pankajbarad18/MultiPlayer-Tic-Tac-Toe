import 'package:flutter/material.dart';
import 'package:multiplayer_o_x/responsive/responsive.dart';
import 'package:multiplayer_o_x/services/socket_method.dart';
import 'package:multiplayer_o_x/widgets/custom_button.dart';
import 'package:multiplayer_o_x/widgets/custom_text.dart';
import 'package:multiplayer_o_x/widgets/custom_textfield.dart';

class CreateRoom extends StatefulWidget {
  static const String routeName = '/create-room';
  const CreateRoom({super.key});

  @override
  State<CreateRoom> createState() => _CreateRoomState();
}

class _CreateRoomState extends State<CreateRoom> {
  final TextEditingController _roomController = TextEditingController();
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    _socketMethods.createSuccessRoomListener(context);
  }

  @override
  void dispose() {
    super.dispose();
    _roomController.dispose();
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
                  text: 'Create Room',
                  shadow: [Shadow(blurRadius: 5, color: Colors.blue)],
                  fontSize: 72),
              SizedBox(height: size.height * 0.08),
              CustomTextField(
                  controller: _roomController,
                  hintText: 'Enter Your code here'),
              SizedBox(height: size.height * 0.045),
              CustomButton(
                  onTap: () {
                    _socketMethods.createRoom(_roomController.text);
                  },
                  text: 'Create')
            ],
          ),
        ),
      ),
    );
  }
}
