import 'package:flutter/cupertino.dart';

class Player {
  final String name;
  int score;
  String icon;

  Player({
    @required this.name,
    this.score = 0,
    this.icon = "secret",
  });

  String getPlayerIconPath() {
    return "assets/player_icons/" + icon + ".png";
  }
}
