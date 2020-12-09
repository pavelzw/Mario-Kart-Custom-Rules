import 'package:flutter/material.dart';
import 'package:mariokartcustomrules/models/player.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app_localizations.dart';

class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({Key key, this.players, this.targetPlace});
  final List<Player> players;
  final int targetPlace;

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('results')),
      ),
      body: FlatButton(
        child: Text("HELLO"),
        onPressed: () async {
          final prefs = await SharedPreferences.getInstance();

          prefs.setBool('hide-welcome-screen', true);

          Navigator.of(context)
              .pushReplacementNamed('/main', arguments: <Player>[]);
        },
      ),
    );
  }
}
