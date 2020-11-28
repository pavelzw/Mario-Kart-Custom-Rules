import 'dart:async';

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

import 'main_screen.dart';

class ResultScreen extends StatefulWidget {
  ResultScreen({Key key, this.players});
  final List<Player> players;
  final String title = "Play";

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  int endTime;
  Timer timer;
  String timerText;
  String revealText;
  int randomPlace;
  bool revealed;

  @override
  void initState() {
    super.initState();

    revealed = false;
    Random random = new Random();
    randomPlace = random.nextInt(12) + 1;
    setState(() {
      revealText = "Reveal";
      timerText = "";
      endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 30;
    });
  }

  String _timePrint(CurrentRemainingTime time) {
    if (time == null) {
      revealed = true;
    }
    if (revealed) {
      return randomPlace.toString();
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
          Text("HELLO"),
        ],
      ),
    );
  }
}
