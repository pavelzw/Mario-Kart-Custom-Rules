import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mariokartcustomrules/views/edit_players.dart';
import 'package:mariokartcustomrules/views/main_screen.dart';

import 'models/player.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => EditPlayers(players: []));
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
