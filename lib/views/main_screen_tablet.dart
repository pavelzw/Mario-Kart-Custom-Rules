import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mkcustomrules/device_manager.dart';
import 'package:mkcustomrules/models/player.dart';
import 'package:mkcustomrules/views/layout_strategies/circle_layout.dart';
import 'package:mkcustomrules/views/layout_strategies/grid_layout.dart';
import 'package:mkcustomrules/views/layout_strategies/layout_strategy.dart';
import 'package:mkcustomrules/views/player_tile.dart';
import 'package:mkcustomrules/views/start_tile.dart';

import '../app_localizations.dart';

class MainScreenTablet extends StatefulWidget {
  final List<Player> players;

  MainScreenTablet({
    @required this.players,
  });

  @override
  _MainScreenTabletState createState() => _MainScreenTabletState();
}

class _MainScreenTabletState extends State<MainScreenTablet> {
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
    return MediaQuery.of(context).size.height * 0.9;
  }

  Point _toPosition(Point point) {
    return Point(point.x - _getTileSize() / 2, point.y - _getTileSize() / 2);
  }

  double _getTileSize() {
    int amountOfPositions = widget.players.length;
    double constant;
    if (amountOfPositions <= 8) {
      constant = 0.27;
    } else if (amountOfPositions <= 10) {
      // 4 on top row
      if (DeviceManager.isLandscapeMode(context)) {
        constant = 0.27;
      } else {
        constant = 0.22;
      }
    } else {
      if (DeviceManager.isLandscapeMode(context)) {
        constant = 0.27;
      } else {
        constant = 0.18;
      }
    }
    return _getShortestSide() * constant;
  }

  LayoutStrategy _getStrategy() {
    int amountOfPositions = widget.players.length;
    if (amountOfPositions <= 6) {
      return CircleLayout(_getWidth(), _getHeight(), amountOfPositions);
    }
    return GridLayout(_getTileSize(), _getWidth(), _getHeight(), amountOfPositions);
  }

  Point _getPosition(int position) {
    LayoutStrategy strategy = _getStrategy();
    return strategy.getPosition(position);
  }

  Point _centerPosition() {
    LayoutStrategy strategy = _getStrategy();
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
          actions: [
            IconButton(
              icon: Icon(Icons.help),
              onPressed: () => Navigator.of(context).pushNamed('/welcome'),
            ),
          ],
        ),
        preferredSize: Size(double.infinity, _appBarHeight),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
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
                      child: StartTile(
                        size: _getTileSize(),
                        onTap: () async {
                          final players = await Navigator.of(context).pushNamed('/game', arguments: this.players);
                          if (players != null) {
                            setState(() {
                              this.players = players;
                            });
                          }
                        },
                      ),
                    ),
                  ),
              ),
              height: _getHeight(),
              width: _getWidth(),
            ),
          ],
        ),
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
