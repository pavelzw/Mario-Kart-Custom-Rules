import 'package:flutter/material.dart';
import 'package:mariokartcustomrules/models/player.dart';
import 'package:mariokartcustomrules/views/edit_player_row.dart';

import '../app_localizations.dart';

class EditPlayers extends StatefulWidget {
  EditPlayers({Key key, this.players});
  final List<Player> players;

  @override
  _EditPlayersState createState() => _EditPlayersState();
}

class _EditPlayersState extends State<EditPlayers> {
  List<Player> players;

  @override
  void initState() {
    super.initState();

    setState(() {
      players = widget.players;
      if (players.isEmpty) {
        players.add(Player(name: ""));
      }
    });
  }

  void _removePlayer(Player player) {
    setState(() {
      players.remove(player);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('edit-players')),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop(players);
              } else {
                // first launch with no players
                Navigator.of(context).pushReplacementNamed('/main', arguments: players);
              }
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          new Expanded(
            child: ListView(
              children: players.map((player) {
                return EditPlayerRow(
                  key: UniqueKey(), // prevent ui update bug
                  player: player,
                  remove: players.length <= 1 ? null : _removePlayer,
                  index: players.indexOf(player),
                );
              }).toList(),
            ),
          ),
        ],
      ),
      floatingActionButton: players.length >= 12
          ? null
          : FloatingActionButton(
              heroTag: 'add',
              tooltip: AppLocalizations.of(context).translate("add-player"),
              onPressed: () {
                setState(() {
                  players.add(Player(name: ""));
                });
              },
              child: Icon(Icons.add),
            ),
    );
  }
}
