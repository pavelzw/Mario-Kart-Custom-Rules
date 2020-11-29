import 'package:flutter/material.dart';

import 'package:rxdart/rxdart.dart';
import 'main_screen.dart';

class ResultScreen extends StatefulWidget {
  ResultScreen({Key key, this.players, this.targetPlace});
  final List<Player> players;
  final int targetPlace;
  final String title = "Play";

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

  int _getPoint(int place) {
    return (place - widget.targetPlace).abs() + 1;
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
                child: Text(_getPoint(e).toString()),
              )));
    GridView placePoints = GridView.count(
      crossAxisCount: 12,
      children: items,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Results'),
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
                          _getPoint(int.parse(place.controller.text))))
              .toList();

          Navigator.pop(context, list);
        },
        child: Icon(Icons.save),
      ),
    );
  }
}
