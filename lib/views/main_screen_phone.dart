import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mariokartcustomrules/models/player.dart';

import '../app_localizations.dart';

class MainScreenPhone extends StatefulWidget {
  final List<Player> players;

  MainScreenPhone({
    @required this.players,
  });

  @override
  _MainScreenPhoneState createState() => _MainScreenPhoneState();
}

class _MainScreenPhoneState extends State<MainScreenPhone>
    with SingleTickerProviderStateMixin {
  List<Player> players;

  @override
  void initState() {
    super.initState();

    setState(() {
      players = widget.players;
    });
  }

  ListTile _createLeaderboardItem(Player player, int position) {
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
            image: AssetImage(player.getPlayerIconPath()),
            height: 45,
          ),
        ],
      ),
      title: Text(player.getPlayerName(context, players.indexOf(player))),
      trailing: Text(player.score.toString()),
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
        actions: [
          IconButton(
            icon: Icon(Icons.help),
            onPressed: () => Navigator.of(context).pushNamed('/welcome'),
          ),
        ],
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
                    padding: const EdgeInsets.all(16),
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
