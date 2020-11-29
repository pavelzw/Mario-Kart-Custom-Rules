import 'dart:async';

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mariokartcustomrules/models/player.dart';
import 'package:mariokartcustomrules/views/result_screen.dart';

import '../app_localizations.dart';

class GameScreen extends StatefulWidget {
  GameScreen({Key key, this.players});
  final List<Player> players;

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int endTime;
  int timeLeft;
  String timeText;
  String buttonText;
  Timer timer;
  int randomPlace;
  bool revealed;

  @override
  void initState() {
    super.initState();
    const defaultDuration = 120;

    endTime = DateTime.now().millisecondsSinceEpoch + 1000 * defaultDuration;

    revealed = false;
    timer = new Timer.periodic(Duration(milliseconds: 500), _update);
    Random random = new Random();
    randomPlace = random.nextInt(12) + 1;

    setState(() {
      timeText = _timePrint(defaultDuration);
    });
  }

  String _timePrint(int time) {
    return '${_getNumberAddZero(time ~/ 60)}:${_getNumberAddZero(time % 60)}';
  }

  void _update(Timer timer) {
    timeLeft =
        max(0, (endTime - DateTime.now().millisecondsSinceEpoch) ~/ 1000);

    if (timeLeft == 0) {
      setState(() {
        _reveal();
      });
    } else {
      setState(() {
        timeText = _timePrint(timeLeft);
      });
    }
  }

  void _reveal() {
    revealed = true;
    timer.cancel();
    setState(() {
      timeText = randomPlace.toString();
    });
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
        title: Text(AppLocalizations.of(context).translate('play')),
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  timeText,
                  style: TextStyle(fontSize: 60),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: FlatButton(
                    child: Text(revealed
                        ? AppLocalizations.of(context)
                            .translate('enter-results')
                        : AppLocalizations.of(context).translate('reveal')),
                    onPressed: () async {
                      if (!revealed) {
                        _reveal();
                      } else {
                        Navigator.pop(
                            context,
                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ResultScreen(
                                          players: widget.players,
                                          targetPlace: randomPlace,
                                        ))));
                      }
                    },
                    color: Colors.blue,
                    textColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
