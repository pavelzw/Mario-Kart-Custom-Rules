import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mariokartcustomrules/models/player.dart';
import 'package:mariokartcustomrules/views/add_players.dart';

import '../app_localizations.dart';
import 'game_screen.dart';

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
      leading: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 8,
        children: [
          CircleAvatar(
            child: Text(position.toString()),
          ),
          Image(
            image: AssetImage(p.getPlayerIconPath()),
            height: 45,
          ),
        ],
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
            final players = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddPlayers(players: this.players),
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
        Expanded(
          child: Text(
            AppLocalizations.of(context).translate('players') +
                (players.length == 0 ? "" : ": ") +
                players.map((player) => player.name).toList().join(", "),
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 20.0),
            textAlign: TextAlign.left,
          ),
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
        title: Text(AppLocalizations.of(context).translate('app-title')),
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
