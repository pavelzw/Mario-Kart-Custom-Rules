import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mariokartcustomrules/device_manager.dart';
import 'package:mariokartcustomrules/models/player.dart';
import 'package:mariokartcustomrules/views/main_screen_phone.dart';
import 'package:mariokartcustomrules/views/main_screen_tablet.dart';

class MainScreen extends StatefulWidget {
  final List<Player> players;

  MainScreen({
    @required this.players,
  });

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    if (DeviceManager.isTablet(context)) {
      return MainScreenTablet(players: widget.players);
    }

    return MainScreenPhone(players: widget.players);
  }
}
