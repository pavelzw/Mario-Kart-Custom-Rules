import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mariokartcustomrules/models/player.dart';

class PlayerTile extends StatelessWidget {
  final Player player;
  final int index;
  final int place;
  final double size;

  PlayerTile({this.player, this.place, this.index, this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      child: Card(
        child: Text(
          player.getPlayerName(context, index),
          style: TextStyle(color: Colors.black, fontSize: 50),
        ),
      ),
    );
  }
}
