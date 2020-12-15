import 'dart:math';

import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:mkcustomrules/device_manager.dart';
import 'package:mkcustomrules/models/player.dart';
import 'package:mkcustomrules/views/start_tile.dart';
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
  Widget _getIcon() {
    return Center(
      child: Image(
        image:
            AssetImage("assets/welcome_page/icon_" + (DeviceManager.isOnIOS(context) ? "flat" : "material") + ".png"),
        height: 300.0,
      ),
    );
  }

  Widget _getPositionImage() {
    return Center(
      child: Image(
        image: AssetImage("assets/positions/position6.png"),
        height: 300.0,
      ),
    );
  }

  Widget _getPointsImage() {
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: Center(
        child: Image(
          image: AssetImage("assets/welcome_page/placement_points.png"),
          height: 300.0,
        ),
      ),
    );
  }

  Widget _getPlayButton() {
    if (DeviceManager.isTablet(context)) {
      double tileSize = min(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height) * 0.27;
      return Center(
        child: SizedBox(
          width: tileSize,
          height: tileSize,
          child: StartTile(
            size: min(MediaQuery.of(context).size.height, MediaQuery.of(context).size.width) * 0.01,
            onTap: () {},
          ),
        ),
      );
    }
    double buttonWidth = MediaQuery.of(context).size.width * 0.8;
    double buttonHeight = MediaQuery.of(context).size.height * 0.07;
    return Center(
      child: SizedBox(
        width: buttonWidth,
        height: buttonHeight,
        child: FlatButton(
          child: Text(AppLocalizations.of(context).translate("play")),
          onPressed: () {},
          color: Colors.blue,
          textColor: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<PageViewModel> pages = !Navigator.of(context).canPop()
        ? [
            PageViewModel(
              title: AppLocalizations.of(context).translate("welcome"),
              body: AppLocalizations.of(context).translate("welcome-to-mk-rules"),
              image: _getIcon(),
            ),
          ]
        : [];
    pages.addAll([
      PageViewModel(
        title: AppLocalizations.of(context).translate("how-this-game-works"),
        body: AppLocalizations.of(context).translate("how-this-game-works-description-1"),
        image: _getIcon(),
      ),
      PageViewModel(
        title: AppLocalizations.of(context).translate("how-this-game-works"),
        body: AppLocalizations.of(context).translate("how-this-game-works-description-2"),
        image: _getPositionImage(),
      ),
      PageViewModel(
        title: AppLocalizations.of(context).translate("how-this-game-works"),
        body: AppLocalizations.of(context).translate("how-this-game-works-description-3"),
        image: _getPointsImage(),
      ),
      PageViewModel(
        title: AppLocalizations.of(context).translate("press-play"),
        body: AppLocalizations.of(context).translate("press-play-description"),
        image: _getPlayButton(),
      )
    ]);

    return IntroductionScreen(
      pages: pages,
      done: Text(AppLocalizations.of(context).translate("got-it"), style: TextStyle(fontWeight: FontWeight.w600)),
      onDone: () async {
        final prefs = await SharedPreferences.getInstance();

        prefs.setBool('hide-welcome-screen', true);

        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        } else {
          Navigator.of(context).pushReplacementNamed('/main', arguments: <Player>[]);
        }
      },
    );
  }
}
