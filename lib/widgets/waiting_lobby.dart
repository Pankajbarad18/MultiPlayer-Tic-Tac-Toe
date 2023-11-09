import 'package:flutter/material.dart';
import 'package:multiplayer_o_x/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

import '../provider/room_data_provider.dart';

class WaitingLobby extends StatefulWidget {
  const WaitingLobby({super.key});

  @override
  State<WaitingLobby> createState() => _WaitingLobbyState();
}

class _WaitingLobbyState extends State<WaitingLobby> {
  @override
  Widget build(BuildContext context) {
    final roomProvider = Provider.of<RoomData>(context).roomData;
    final TextEditingController roomController =
        TextEditingController(text: roomProvider['_id']);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('waiting for the other Players to join'),
        const SizedBox(height: 20),
        CustomTextField(
          controller: roomController,
          hintText: '',
          isReadOnly: true,
        )
      ],
    );
  }
}
