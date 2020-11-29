import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mariokartcustomrules/views/add_players.dart';

import 'game_screen.dart';

class Player {
  final String name;
  int score;

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
  List<Player> players;

  @override
  void initState() {
    super.initState();

    setState(() {
      players = [];
    });
  }

  ListTile _createLeaderboardItem(Player p, int position) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(position.toString()),
      ),
      title: Text(p.name),
      trailing: Text(p.score.toString()),
    );
  }

  @override
  Widget build(BuildContext context) {
    Row playerEdit = Row(
      children: [
        IconButton(
          icon: Icon(Icons.edit),
          onPressed: () async {
            final playerNames = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddPlayers(
                    data: players.map((player) => player.name).toList()),
                fullscreenDialog: true,
              ),
            );

            if (playerNames != null) {
              setState(() {
                players = List<Player>.from(
                    playerNames.map((name) => Player(name: name)).toList());
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
    );

    // leaderboard
    List<Player> playersSort = List.from(players);
    playersSort.sort((p1, p2) => p2.score - p1.score);
    List<ListTile> leaderboardTiles = playersSort
        .map((p) => _createLeaderboardItem(p, playersSort.indexOf(p) + 1))
        .toList();
    ListView leaderboard = ListView(
      physics: NeverScrollableScrollPhysics(),
      children: ListTile.divideTiles(
        context: context,
        tiles: leaderboardTiles,
      ).toList(),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Mario Kart Custom Rules'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: <Widget>[
            playerEdit,
            Expanded(
              child: leaderboard,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.videogame_asset),
        onPressed: () async {
          final players = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GameScreen(players: this.players),
              fullscreenDialog: true,
            ),
          );
          if (players != null) {
            setState(() {
              this.players = players;
            });
          }
        },
      ),
    );
  }
}
