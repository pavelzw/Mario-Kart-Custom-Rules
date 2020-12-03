import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mariokartcustomrules/models/player.dart';
import 'package:mariokartcustomrules/views/player_tile.dart';

import '../app_localizations.dart';

class MainScreenTablet extends StatefulWidget {
  final List<Player> players;

  MainScreenTablet({
    @required this.players,
  });

  @override
  _MainScreenTabletState createState() => _MainScreenTabletState();
}

class _MainScreenTabletState extends State<MainScreenTablet> with SingleTickerProviderStateMixin {
  List<Player> players;
  double _appBarHeight = 50;

  @override
  void initState() {
    super.initState();

    setState(() {
      players = widget.players;
    });
  }

  double _getShortestSide() {
    return min(_getHeight(), _getWidth());
  }

  double _getWidth() {
    return MediaQuery.of(context).size.width;
  }

  double _getHeight() {
    return MediaQuery.of(context).size.height - 74;
  }

  Point _getCenter() {
    return Point(_getWidth() / 2, _getHeight() / 2);
  }

  Point _toPosition(Point point) {
    return Point(point.x - _getTileSize() / 2, point.y - _getTileSize() / 2);
  }

  double _getTileSize() {
    return _getShortestSide() * 0.25;
  }

  Point _getPointOnCircle(int position, int numberOfPositions) {
    double radius = _getShortestSide() * 0.35;

    double anglePerPoint = 2 * pi / numberOfPositions;

    double angle = anglePerPoint * position;
    return Point(_getCenter().x + radius * sin(angle), _getCenter().y - radius * cos(angle));
  }

  @override
  Widget build(BuildContext context) {
    // leaderboard
    List<Player> playersSort = List.from(players);
    playersSort.sort((p1, p2) => p2.score - p1.score);

    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          title: Text(AppLocalizations.of(context).translate('app-title')),
        ),
        preferredSize: Size(double.infinity, _appBarHeight),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            child: Stack(
              children: players.map(
                (player) {
                  int playerIndex = players.indexOf(player);
                  int playerPlace = playersSort.indexOf(player);

                  return Positioned(
                    top: _toPosition(_getPointOnCircle(playerIndex, players.length)).y,
                    left: _toPosition(_getPointOnCircle(playerIndex, players.length)).x,
                    child: PlayerTile(
                      player: player,
                      place: playerPlace + 1,
                      index: playerIndex,
                      size: _getTileSize(),
                    ),
                  );
                },
              ).toList()
                ..add(
                  Positioned(
                    top: _toPosition(_getCenter()).y,
                    left: _toPosition(_getCenter()).x,
                    child: PlayerTile(
                      player: players[0],
                      place: 1,
                      index: 2,
                      size: _getTileSize(),
                    ),
                  ),
                ),
            ),
            height: _getHeight(),
            width: _getWidth(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.edit),
        tooltip: AppLocalizations.of(context).translate("edit-players"),
        onPressed: () async {
          final players = await Navigator.of(context).pushNamed('/edit-players', arguments: this.players);

          if (players != null) {
            setState(() {
              this.players = players;
            });
          }
        },
      ),
    );
  }
}
