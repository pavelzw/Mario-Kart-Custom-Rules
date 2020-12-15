import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mkcustomrules/device_manager.dart';
import 'package:mkcustomrules/models/player.dart';
import 'package:mkcustomrules/views/main_screen_phone.dart';
import 'package:mkcustomrules/views/main_screen_tablet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class MainScreen extends StatefulWidget {
  final List<Player> players;

  MainScreen({
    @required this.players,
  });

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Future<List<Player>> _checkPreferences() async {
    final prefs = await SharedPreferences.getInstance();

    bool hideWelcomeScreen = prefs.getBool('hide-welcome-screen');
    if (hideWelcomeScreen == null || !hideWelcomeScreen) {
      Navigator.of(context).pushReplacementNamed('/welcome');
      return null;
    }

    if (widget.players.isEmpty) {
      List<String> playersJsonStr = prefs.getStringList('players');
      debugPrint("Got from SharedPreferences: " + playersJsonStr.toString());

      if (playersJsonStr == null || playersJsonStr.isEmpty) {
        Navigator.of(context).pushReplacementNamed('/edit-players', arguments: []);
        return null;
      }
      List<Player> players = playersJsonStr.map((jsonStr) => Player.fromJson(json.decode(jsonStr))).toList();

      widget.players.addAll(players);
      return players;
    }
    return widget.players;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _checkPreferences(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (DeviceManager.isTablet(context)) {
            return MainScreenTablet(players: snapshot.data);
          }

          return MainScreenPhone(players: snapshot.data);
        }
        return CircularProgressIndicator();
      },
    );
  }
}
