import 'package:flutter/cupertino.dart';

class Player {
  final String name;
  int score;
  String playerIcon;

  Player({
    @required this.name,
    this.score = 0,
    this.playerIcon = "secret",
  });

  String getPlayerIconPath() {
    return "assets/player_icons/" + playerIcon + ".png";
  }
}
