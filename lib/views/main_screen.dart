import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mariokartcustomrules/device_manager.dart';
import 'package:mariokartcustomrules/admob_service.dart';
import 'package:mariokartcustomrules/models/player.dart';
import 'package:mariokartcustomrules/views/main_screen_phone.dart';
import 'package:mariokartcustomrules/views/main_screen_tablet.dart';
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
  @override
  void initState() {
    super.initState();
    //AdMobService.getInstance().showHomeBannerAd();
    _checkPreferences();
  }

  @override
  void dispose() {
    //AdMobService.getInstance().hideHomeBannerAd();
    super.dispose();
  }

  Future<Null> _checkPreferences() async {
    if (widget.players.isEmpty) {
      final prefs = await SharedPreferences.getInstance();

      List<String> playersJsonStr = prefs.getStringList('players');
      debugPrint("Got from SharedPreferences: " + playersJsonStr.toString());

      if (playersJsonStr == null || playersJsonStr.isEmpty) {
        Navigator.of(context)
            .pushReplacementNamed('/edit-players', arguments: []);
        return;
      }
      List<Player> players = playersJsonStr
          .map((jsonStr) => Player.fromJson(json.decode(jsonStr)))
          .toList();

      Navigator.of(context).pushReplacementNamed('/main', arguments: players);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (DeviceManager.isTablet(context)) {
      return MainScreenTablet(players: widget.players);
    }

    return MainScreenPhone(players: widget.players);
  }
}
