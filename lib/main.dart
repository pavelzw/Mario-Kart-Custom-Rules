import 'package:flutter/material.dart';
import 'package:mariokartcustomrules/views/create_players.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mario Kart Custom Rules',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CreatePlayersPage(title: 'Create players'),
    );
  }
}