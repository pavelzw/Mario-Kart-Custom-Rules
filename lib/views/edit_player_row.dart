import 'package:flutter/material.dart';
import 'package:mariokartcustomrules/models/player.dart';
import 'package:mariokartcustomrules/views/icon_picker.dart';

import '../app_localizations.dart';

class EditPlayerRow extends StatefulWidget {
  final Player player;
  final Function(Player) remove;

  EditPlayerRow({Key key, @required this.player, @required this.remove});

  @override
  _EditPlayerRowState createState() => _EditPlayerRowState();
}

class _EditPlayerRowState extends State<EditPlayerRow> {
  TextEditingController _controller;

  Future<void> _showIconPickerDialog(Player player) async {
    String iconName = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            AppLocalizations.of(context).translate('pick-icon'),
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

    _controller = TextEditingController();

    _controller.addListener(() {
      widget.player.name = _controller.text;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                image: AssetImage(widget.player.getPlayerIconPath()),
              ),
              onPressed: () => _showIconPickerDialog(widget.player),
            ),
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).translate('player') +
                    " " +
                    widget.player.index.toString(), // todo to PlayerText
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: widget.remove == null ? null : () => widget.remove(widget.player),
          )
        ],
      ),
    );
  }
}
