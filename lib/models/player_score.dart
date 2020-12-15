import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:mkcustomrules/models/player.dart';

class PlayerScore {
  static final Map<int, int> pointMap = {1: 15, 2: 12, 3: 10, 4: 9, 5: 8, 6: 7, 7: 6, 8: 5, 9: 4, 10: 3, 11: 2, 12: 1};
  Player player;
  int place;
  int targetPlace;
  int get pointsThisRound {
    return _getPoints();
  }

  PlayerScore({@required this.player, @required this.targetPlace});

  int _getPoints() {
    if (place == null || place > pointMap.length || place <= 0) return 0;
    // convertedPlace is of this form
    //  1  2  3  4  5  t  7  8  9 10 11 12
    //  10 8  6  4  2  1  3  5  7  9 11 12
    // so it is better to be one place in front of the target than behind it
    int distance = min(targetPlace - 1, pointMap.length - targetPlace);

    int convertedPlace;
    if (place >= targetPlace - distance && place <= targetPlace + distance) {
      if (place < targetPlace) {
        convertedPlace = 2 * (targetPlace - place);
      } else {
        convertedPlace = 1 + 2 * (place - targetPlace);
      }
    } else {
      convertedPlace = distance + 1 + (targetPlace - place).abs();
    }

    // default Mario Kart point conversion
    return pointMap[convertedPlace];
  }
}
