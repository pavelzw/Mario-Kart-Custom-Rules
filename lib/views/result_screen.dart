import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mariokartcustomrules/models/player.dart';

import 'package:rxdart/rxdart.dart';
import '../app_localizations.dart';

class ResultScreen extends StatefulWidget {
  ResultScreen({Key key, this.players, this.targetPlace});
  final List<Player> players;
  final int targetPlace;

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  List<TextField> textFields;
  List<Row> rows;

  @override
  void initState() {
    super.initState();

    textFields = widget.players
        .map((player) => TextField(
              controller: TextEditingController(),
              decoration: InputDecoration(labelText: player.name),
              keyboardType: TextInputType.number,
            ))
        .toList();

    rows = [];
    for (int i = 0; i < widget.players.length; i++) {
      Player player = widget.players[i];
      TextField textField = textFields[i];
      rows.add(Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
            child: Image(
              image: AssetImage(player.getPlayerIconPath()),
              height: 45,
            ),
          ),
          Expanded(child: textField),
        ],
      ));
    }
  }

  int _getPoints(int place) {
    const Map<int, int> pointMap = {1: 15, 2: 12, 3: 10, 4: 9, 5: 8, 6: 7, 7: 6, 8: 5, 9: 4, 10: 3, 11: 2, 12: 1};
    // convertedPlace is of this form
    //  1  2  3  4  5  t  7  8  9 10 11 12
    //  10 8  6  4  2  1  3  5  7  9 11 12
    // so it is better to be one place in front of the target than behind it
    int targetPlace = widget.targetPlace;
    int distance = min(targetPlace - 1, pointMap.length - targetPlace);

    int convertedPlace;
    if (place >= targetPlace - distance && place <= targetPlace + distance) {
      if (place < targetPlace) {
        convertedPlace = 2 * (targetPlace - place);
      } else {
        convertedPlace = 1 + 2 * (place - targetPlace);
      }
    } else {
      convertedPlace = distance + 1 + (targetPlace - place).abs();
    }

    // default Mario Kart point conversion
    return pointMap[convertedPlace];
  }

  @override
  Widget build(BuildContext context) {
    List<int> positions = new List<int>.generate(12, (i) => i + 1);
    List<Center> items = positions
        .map((e) => Center(
              child: Text(e.toString()),
            ))
        .toList()
          ..addAll(positions.map((e) => Center(
                child: Text(_getPoints(e).toString()),
              )));
    GridView placePoints = GridView.count(
      crossAxisCount: 12,
      children: items,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('results')),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 75,
              child: placePoints,
            ),
            Container(
              child: Column(
                children: rows,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Stream<Player> playerStream = Stream.fromIterable(widget.players);
          Stream<TextField> textFieldStream = Stream.fromIterable(textFields);

          List<Player> list = await playerStream
              .zipWith(
                  textFieldStream,
                  (player, place) => Player(
                      name: player.name,
                      score: player.score + _getPoints(int.parse(place.controller.text)),
                      icon: player.icon))
              .toList();

          Navigator.pop(context, list);
        },
        child: Icon(Icons.save),
      ),
    );
  }
}
