import 'package:flutter/material.dart';
import 'package:mariokartcustomrules/models/player.dart';
import 'package:mariokartcustomrules/views/icon_picker.dart';

import '../app_localizations.dart';

class PlayerEntry {
  final Player player;
  TextEditingController controller;

  PlayerEntry({
    @required this.player,
    @required this.controller,
  });
}

class AddPlayers extends StatefulWidget {
  AddPlayers({Key key, this.players});
  final List<Player> players;

  @override
  _AddPlayersState createState() => _AddPlayersState();
}

class _AddPlayersState extends State<AddPlayers> {
  List<PlayerEntry> entries;

  Container _getEntry(PlayerEntry e) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
            child: IconButton(
              iconSize: 50,
              icon: Image(
                image: AssetImage(e.player.getPlayerIconPath()),
              ),
              onPressed: () => _showIconPickerDialog(e.player),
            ),
          ),
          Expanded(
            child: TextField(
              controller: e.controller,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).translate('player') +
                    " " +
                    (entries.indexOf(e) + 1).toString(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showIconPickerDialog(Player player) async {
    String iconName = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Pick an icon',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: IconPicker(),
        );
      },
    );

    if (iconName != null) {
      debugPrint('Icon changed to $iconName');
      setState(() {
        player.icon = iconName;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      if (widget.players.isNotEmpty) {
        entries = widget.players
            .map((p) => PlayerEntry(
                player: p, controller: TextEditingController(text: p.name)))
            .toList();
      } else {
        Player defaultPlayer = Player(name: "");
        entries = [
          PlayerEntry(
              player: defaultPlayer, controller: TextEditingController())
        ];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('add-players')),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              if (entries.isEmpty) {
                print(
                    AppLocalizations.of(context).translate('no-players-error'));
                return;
              }

              final List<Player> players = entries
                  .map((e) => Player(
                        name: e.controller.text == ""
                            ? AppLocalizations.of(context).translate('player') +
                                " " +
                                (entries.indexOf(e) + 1).toString()
                            : e.controller.text,
                        icon: e.player.icon,
                        score: e.player.score,
                      ))
                  .toList();

              Navigator.pop(context, players);
            },
          )
        ],
      ),
      body: entries == null
          ? CircularProgressIndicator()
          : Column(
              children: <Widget>[
                new Expanded(
                  child: ListView(
                    children: entries.map(_getEntry).toList(),
                  ),
                ),
              ],
            ),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: 'min',
            onPressed: () {
              setState(() {
                entries.removeLast();
              });
            },
            child: Icon(Icons.remove),
          ),
          SizedBox(width: 8),
          FloatingActionButton(
            heroTag: 'add',
            onPressed: () {
              setState(() {
                entries.add(PlayerEntry(
                    player: Player(name: ""),
                    controller: TextEditingController()));
              });
            },
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
