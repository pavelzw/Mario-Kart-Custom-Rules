import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:mariokartcustomrules/models/player_score.dart';

class Player {
  String name;
  int score;
  String icon;

  Player({
    @required this.name,
    this.score = 0,
    this.icon = "secret",
  });

  Player.of(PlayerScore playerScore) {
    name = playerScore.player.name;
    score = playerScore.player.score + playerScore.pointsThisRound;
    icon = playerScore.player.icon;
  }

  String getPlayerIconPath() {
    return "assets/player_icons/" + icon + ".png";
  }
}
