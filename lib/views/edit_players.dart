import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mariokartcustomrules/device_manager.dart';
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

  _showResetDialog() {
    Future<bool> reset;
    var _false = () => Navigator.of(context).pop(false);
    var _true = () => Navigator.of(context).pop(true);
    if (DeviceManager.isOnIOS(context)) {
      reset = _showCupertinoResetDialog(_false, _true);
    } else {
      reset = _showMaterialResetDialog(_false, _true);
    }
    reset.then((reset) {
      if (reset) {
        List<Player> resetPlayers = players
            .map((player) => Player(
                  name: player.name,
                  icon: player.icon,
                ))
            .toList();
        Player.saveToPreferences(resetPlayers);
        Navigator.of(context).pop(resetPlayers);
      }
    });
  }

  Future<bool> _showMaterialResetDialog(Function actionNo, Function actionYes) {
    return showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text(AppLocalizations.of(context)
                  .translate("reset-scores-dialog-title")),
              content: Text(AppLocalizations.of(context)
                  .translate("reset-scores-dialog-content")),
              actions: <Widget>[
                FlatButton(
                  child: Text(AppLocalizations.of(context).translate("no")),
                  onPressed: actionNo,
                ),
                FlatButton(
                  child: Text(AppLocalizations.of(context).translate("yes")),
                  onPressed: actionYes,
                ),
              ],
            ));
  }

  Future<bool> _showCupertinoResetDialog(
      Function actionNo, Function actionYes) {
    return showDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
              title: Text(AppLocalizations.of(context)
                  .translate("reset-scores-dialog-title")),
              content: Text(AppLocalizations.of(context)
                  .translate("reset-scores-dialog-content")),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text(AppLocalizations.of(context).translate("no")),
                  onPressed: actionNo,
                ),
                CupertinoDialogAction(
                  child: Text(AppLocalizations.of(context).translate("yes")),
                  onPressed: actionYes,
                ),
              ],
            ));
  }

  bool _canResetScores() {
    return players.fold(
        false, (previousValue, player) => previousValue || player.score > 0);
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      players = widget.players;
      if (players.isEmpty) {
        players.add(Player());
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
          Visibility(
            visible: _canResetScores(),
            child: IconButton(
              icon: Icon(Icons.restore),
              onPressed: () => _showResetDialog(),
            ),
          ),
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              Player.saveToPreferences(players);
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop(players);
              } else {
                // first launch with no players
                Navigator.of(context)
                    .pushReplacementNamed('/main', arguments: players);
              }
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
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
