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
  @override
  void initState() {
    super.initState();

    setState(() {
      if (widget.players.isEmpty) {
        widget.players.add(Player(
          name: "",
          index: 1,
        ));
      }
    });
  }

  void _removePlayer(Player player) {
    setState(() {
      widget.players.remove(player);
    });
    _updatePlayerIndices();
  }

  void _updatePlayerIndices() {
    for (Player player in widget.players) {
      setState(() {
        player.index = widget.players.indexOf(player) + 1;
      });
    }
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
                Navigator.of(context).pop(widget.players);
              } else {
                // first launch with no players
                Navigator.of(context).pushReplacementNamed('/main', arguments: widget.players);
              }
            },
          ),
        ],
      ),
      body: widget.players == null || widget.players.isEmpty
          ? CircularProgressIndicator()
          : Column(
              children: <Widget>[
                new Expanded(
                  child: ListView(
                    children: widget.players
                        .map((player) =>
                            EditPlayerRow(player: player, remove: widget.players.length <= 1 ? null : _removePlayer))
                        .toList(),
                  ),
                ),
              ],
            ),
      floatingActionButton: widget.players.length >= 12
          ? null
          : FloatingActionButton(
              heroTag: 'add',
              tooltip: AppLocalizations.of(context).translate("add-player"),
              onPressed: () {
                setState(() {
                  widget.players.add(Player(
                    name: "",
                    index: widget.players.length + 1,
                  ));
                });
              },
              child: Icon(Icons.add),
            ),
    );
  }
}
