import 'package:flutter/material.dart';
import 'package:multiplayer_o_x/Screens/create_room.dart';
import 'package:multiplayer_o_x/Screens/game_screen.dart';
import 'package:multiplayer_o_x/Screens/join_room.dart';
import 'package:multiplayer_o_x/Screens/main_screen.dart';
import 'package:multiplayer_o_x/provider/room_data_provider.dart';
import 'package:multiplayer_o_x/utilities/colors.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RoomData(),
      child: MaterialApp(
        title: 'Tic Tac Toe',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: bgColor),
        routes: {
          MainScreen.routeName: (context) => const MainScreen(),
          CreateRoom.routeName: (context) => const CreateRoom(),
          JoinRoom.routeName: (context) => const JoinRoom(),
          GameScreen.routeName: (context) => const GameScreen()
        },
        // home: const MainScreen(),
        initialRoute: MainScreen.routeName,
      ),
    );
  }
}
