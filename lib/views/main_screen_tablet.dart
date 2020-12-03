import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mariokartcustomrules/models/player.dart';
import 'package:mariokartcustomrules/views/layout_strategies/circle_layout.dart';
import 'package:mariokartcustomrules/views/layout_strategies/grid_layout.dart';
import 'package:mariokartcustomrules/views/layout_strategies/layout_strategy.dart';
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

  Point _toPosition(Point point) {
    return Point(point.x - _getTileSize() / 2, point.y - _getTileSize() / 2);
  }

  double _getTileSize() {
    return _getShortestSide() * 0.25;
  }

  Point _getPosition(int position) {
    LayoutStrategy strategy;
    int amountOfPositions = widget.players.length;
    if (amountOfPositions <= 6) {
      strategy = CircleLayout(_getWidth(), _getHeight(), amountOfPositions);
    } else {
      strategy = GridLayout(_getWidth(), _getHeight(), amountOfPositions);
    }
    return strategy.getPosition(position);
  }

  Point _centerPosition() {
    LayoutStrategy strategy;
    int amountOfPositions = widget.players.length;
    if (amountOfPositions <= 6) {
      strategy = CircleLayout(_getWidth(), _getHeight(), amountOfPositions);
    } else {
      strategy = GridLayout(_getWidth(), _getHeight(), amountOfPositions);
    }
    return strategy.centerPosition();
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
                  Point pos = _getPosition(playerIndex);
                  return Positioned(
                    top: _toPosition(pos).y,
                    left: _toPosition(pos).x,
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
                    top: _toPosition(_centerPosition()).y,
                    left: _toPosition(_centerPosition()).x,
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
