import 'package:flutter/cupertino.dart';
import 'package:mariokartcustomrules/app_localizations.dart';
import 'package:mariokartcustomrules/models/player_score.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

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

  @override
  String toString() {
    return "Player(" + name + ", " + score.toString() + ", " + icon + ")";
  }

  static String getDefaultName(BuildContext context, int index) {
    // index is the index of the player list, so 0-based
    return AppLocalizations.of(context).translate('player') + " " + (index + 1).toString();
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'score': score,
        'icon': icon,
      };

  Player.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        score = json['score'],
        icon = json['icon'];

  static Future<Null> saveToPreferences(List<Player> players) async {
    List<String> playersJson = players.map((player) => json.encode(player.toJson())).toList();

    debugPrint("Player list as JSON: " + playersJson.toString());

    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('players', playersJson);
  }
}
