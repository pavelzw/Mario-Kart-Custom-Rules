import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mariokartcustomrules/models/player.dart';
import 'package:mariokartcustomrules/views/edit_players.dart';

import '../app_localizations.dart';
import 'game_screen.dart';

class MainScreen extends StatefulWidget {
  final List<Player> players;

  MainScreen({
    @required this.players,
  });

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  List<Player> players;

  @override
  void initState() {
    super.initState();

    setState(() {
      players = widget.players;
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: FlatButton(
                      child:
                          Text(AppLocalizations.of(context).translate("play")),
                      onPressed: () async {
                        final players = await Navigator.of(context)
                            .pushNamed('/game', arguments: this.players);
                        if (players != null) {
                          setState(() {
                            this.players = players;
                          });
                        }
                      },
                      color: Colors.blue,
                      textColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: leaderboard,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.edit),
        tooltip: AppLocalizations.of(context).translate("edit-players"),
        onPressed: () async {
          final players = await Navigator.of(context)
              .pushNamed('/edit-players', arguments: this.players);

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
