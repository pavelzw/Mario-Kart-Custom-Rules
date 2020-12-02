import 'package:flutter/material.dart';
import 'package:mariokartcustomrules/models/player.dart';
import 'package:mariokartcustomrules/models/player_score.dart';
import 'package:mariokartcustomrules/views/result_player_row.dart';

import '../app_localizations.dart';

class ResultScreen extends StatefulWidget {
  ResultScreen({Key key, this.players, this.targetPlace});
  final List<Player> players;
  final int targetPlace;

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  List<PlayerScore> playerScores;
  bool cannotSave;

  @override
  void initState() {
    super.initState();
    cannotSave = true;
    playerScores = widget.players
        .map(
          (player) => PlayerScore(
            player: player,
            targetPlace: widget.targetPlace,
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('results')),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 16, 0, 8),
              child: Text(
                AppLocalizations.of(context).translate('enter-results-description'),
                style: TextStyle(fontSize: 16),
              ),
            ),
            Container(
              child: Column(
                children: playerScores.map((player) => ResultPlayerRow(player, () => setState(() {}))).toList(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _cannotSave()
          ? null
          : FloatingActionButton(
              onPressed: () async {
                List<Player> list = playerScores.map((playerScore) => Player.of(playerScore)).toList();

                Navigator.pop(context, list);
              },
              child: Icon(Icons.save),
            ),
    );
  }

  bool _cannotSave() {
    return playerScores.fold(false, (previousValue, element) => previousValue || element.pointsThisRound == 0);
  }
}
