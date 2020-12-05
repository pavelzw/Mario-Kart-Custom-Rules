import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mariokartcustomrules/views/edit_players.dart';
import 'package:mariokartcustomrules/views/game_screen.dart';
import 'package:mariokartcustomrules/views/main_screen.dart';
import 'package:mariokartcustomrules/views/result_screen.dart';

import 'models/player.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    debugPrint("Routing to " + settings.name);

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => MainScreen(players: []));
      case '/main':
        if (args is List<Player>) {
          return MaterialPageRoute(builder: (_) => MainScreen(players: args));
        }
        return _errorRoute();
      case '/edit-players':
        if (args is List<Player>) {
          return MaterialPageRoute(
            builder: (_) => EditPlayers(players: args),
          );
        }
        return MaterialPageRoute(
          builder: (_) => EditPlayers(players: []),
        );
      case '/game':
        if (args is List<Player>) {
          return MaterialPageRoute(
              builder: (_) => GameScreen(
                    players: args,
                  ));
        }
        return _errorRoute();
      case '/results':
        if (args is Map) {
          int targetPlace = args['target-place'];
          List<Player> players = args['players'];
          return MaterialPageRoute(
              builder: (_) => ResultScreen(
                    players: players,
                    targetPlace: targetPlace,
                  ));
        }
        return _errorRoute();
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: Text("Error")),
        body: Center(child: Text("An error occurred.")),
      ),
    );
  }
}
