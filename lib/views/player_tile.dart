import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mariokartcustomrules/app_localizations.dart';
import 'package:mariokartcustomrules/models/player.dart';

class PlayerTile extends StatelessWidget {
  final Player player;
  final int index;
  final int place;
  final double size;

  PlayerTile({this.player, this.place, this.index, this.size});

  Image _getPositionImage(int place) {
    return Image(
      image: AssetImage("assets/positions/position" + place.toString() + ".png"),
      height: 80,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      child: Card(
        color: Color.fromRGBO(240, 240, 240, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 16,
              left: 16,
              child: Image(
                image: AssetImage(player.getPlayerIconPath()),
                height: 100,
              ),
            ),
            Positioned(
              bottom: 16.0 + 80,
              left: 16,
              right: 16,
              child: _getPositionImage(place),
            ),
            Positioned(
              top: 40,
              right: 16,
              child: Text(
                player.score.toString() + " " + AppLocalizations.of(context).translate("points"),
                style: TextStyle(fontSize: 48),
                textAlign: TextAlign.center,
              ),
            ),
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Text(
                player.getPlayerName(context, index),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 48),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
