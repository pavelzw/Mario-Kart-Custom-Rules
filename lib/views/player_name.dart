import 'package:flutter/material.dart';
import 'package:mariokartcustomrules/models/player.dart';

import '../app_localizations.dart';

class PlayerText extends StatefulWidget {
  final Player player;
  final TextStyle textStyle;

  PlayerText({Key key, this.player, this.textStyle});

  @override
  _PlayerTextState createState() => _PlayerTextState();
}

class _PlayerTextState extends State<PlayerText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.player.name.isEmpty
          ? AppLocalizations.of(context).translate('player') + " " + widget.player.index.toString()
          : widget.player.name,
      style: widget.textStyle ?? TextStyle(),
    );
  }
}
