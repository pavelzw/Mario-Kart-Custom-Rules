import 'dart:math';

import 'package:mariokartcustomrules/views/layout_strategies/layout_strategy.dart';

class CircleLayout extends LayoutStrategy {
  CircleLayout(double screenWidth, double screenHeight, int amountOfPositions)
      : super(screenWidth, screenHeight, amountOfPositions);

  double _getShortestSide() {
    return min(screenWidth, screenHeight);
  }

  @override
  Point<num> getPosition(int position) {
    double radius = _getShortestSide() * 0.35;

    double anglePerPoint = 2 * pi / amountOfPositions;

    double angle = anglePerPoint * position;
    return Point(center.x + radius * sin(angle), center.y - radius * cos(angle));
  }

  @override
  Point<num> centerPosition() {
    return center;
  }
}
