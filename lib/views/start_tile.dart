import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mariokartcustomrules/app_localizations.dart';
import 'package:mariokartcustomrules/models/player.dart';

class StartTile extends StatelessWidget {
  final double size;
  final Function onTap;

  StartTile({this.size, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(200.0),
        ),
        child: Container(
          child: GestureDetector(
            child: Image(
              image: AssetImage("assets/race_flag.png"),
              height: 100,
            ),
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}
