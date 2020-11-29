import 'package:flutter/material.dart';
import 'package:mariokartcustomrules/models/player.dart';

import 'package:rxdart/rxdart.dart';
import '../app_localizations.dart';
import 'main_screen.dart';

class ResultScreen extends StatefulWidget {
  ResultScreen({Key key, this.players, this.targetPlace});
  final List<Player> players;
  final int targetPlace;

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  List<TextField> textFields;

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
  }

  int _getPoints(int place) {
    // convertedPlace is of this form
    //  1  2  3  4  5  t  7  8  9 10 11 12
    //  10 8  6  4  2  1  3  5  7  9 11 12
    // so it is better to be one place in front of the target than behind it
    int convertedPlace;
    if (place == widget.targetPlace) {
      convertedPlace = 1;
    } else if (place > 2 * widget.targetPlace - 1) {
      convertedPlace = place;
    } else if (place > widget.targetPlace) {
      convertedPlace = (place - widget.targetPlace) * 2 + 1;
    } else if (place < 2 * widget.targetPlace - 12 - 1) {
      convertedPlace = 12 - place + 1;
    } else {
      convertedPlace = (widget.targetPlace - place) * 2;
    }

    // default Mario Kart point conversion
    int points;
    switch (convertedPlace) {
      case 1:
        points = 15;
        break;
      case 2:
        points = 12;
        break;
      case 3:
        points = 10;
        break;
      case 4:
        points = 9;
        break;
      case 5:
        points = 8;
        break;
      case 6:
        points = 7;
        break;
      case 7:
        points = 6;
        break;
      case 8:
        points = 5;
        break;
      case 9:
        points = 4;
        break;
      case 10:
        points = 3;
        break;
      case 11:
        points = 2;
        break;
      case 12:
        points = 1;
        break;
    }

    return points;
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
                children: textFields,
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
                      score: player.score +
                          _getPoints(int.parse(place.controller.text)),
                      icon: player.icon))
              .toList();

          Navigator.pop(context, list);
        },
        child: Icon(Icons.save),
      ),
    );
  }
}
