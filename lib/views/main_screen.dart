import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mariokartcustomrules/views/add_players.dart';

class Player {
  final String name;
  final int score;

  Player({
    @required this.name,
    this.score = 0,
  });
}

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainScreenState();
  }
}

class MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  List<Player> players = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mario Kart Custom Rules'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () async {
                    final playerNames = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddPlayers(
                            data:
                                players.map((player) => player.name).toList()),
                        fullscreenDialog: true,
                      ),
                    );

                    if (playerNames != null) {
                      setState(() {
                        players = List<Player>.from(playerNames
                            .map((name) => Player(name: name))
                            .toList());
                      });
                    }
                  },
                ),
                Text(
                  "Players: " +
                      players.map((player) => player.name).toList().join(", "),
                  style: TextStyle(fontSize: 20.0),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
