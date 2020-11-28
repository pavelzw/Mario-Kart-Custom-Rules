import 'dart:async';

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown.dart';
import 'package:flutter_countdown_timer/countdown_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

import 'main_screen.dart';

class GameScreen extends StatefulWidget {
  GameScreen({Key key, this.players});
  final List<Player> players;
  final String title = "Play";

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int endTime;
  Timer timer;
  String timerText;

  @override
  void initState() {
    super.initState();

    setState(() {
      timerText = "";
      endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 30;
    });
  }

  String _timePrint(CurrentRemainingTime time) {
    if (time == null) {
      return "FINITO";
    }
    return '${_getNumberAddZero(time.min ?? 0)}:${_getNumberAddZero(time.sec ?? 0)}';
  }

  String _getNumberAddZero(int time) {
    if (time ~/ 10 == 0) {
      return "0" + time.toString();
    }
    return time.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Play'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CountdownTimer(
                  endTime: endTime,
                  widgetBuilder: (_, CurrentRemainingTime time) {
                    return Text(
                      _timePrint(time),
                      style: TextStyle(fontSize: 60),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
