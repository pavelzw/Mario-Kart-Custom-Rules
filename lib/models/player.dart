import 'package:flutter/cupertino.dart';
import 'package:mariokartcustomrules/app_localizations.dart';
import 'package:mariokartcustomrules/models/player_score.dart';

class Player {
  String name;
  int score;
  String icon;

  Player({
    this.name = "",
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

  String getPlayerName(BuildContext context, int index) {
    // index is the index of the player list, so 0-based
    return name.isEmpty ? getDefaultName(context, index) : name;
  }

  static String getDefaultName(BuildContext context, int index) {
    // index is the index of the player list, so 0-based
    return AppLocalizations.of(context).translate('player') +
        " " +
        (index + 1).toString();
  }
}
