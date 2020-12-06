import 'dart:math';

import 'package:mariokartcustomrules/views/layout_strategies/layout_strategy.dart';

class CircleLayout extends LayoutStrategy {
  CircleLayout(double screenWidth, double screenHeight, int amountOfPositions)
      : super(screenWidth, screenHeight, amountOfPositions);

  double get shortestSide => min(screenWidth, screenHeight);

  double get anglePerPoint => 2 * pi / amountOfPositions;

  double get radius => shortestSide * 0.35;

  double get verticalOffset {
    double extremeAngle = anglePerPoint * (amountOfPositions ~/ 2);
    double bottomHeight = radius * cos(extremeAngle).abs();
    return radius - bottomHeight;
  }

  @override
  Point<num> getPosition(int position) {
    double angle = anglePerPoint * position;
    return Point(center.x + radius * sin(angle),
        center.y - radius * cos(angle) + verticalOffset / 2);
  }

  @override
  Point<num> centerPosition() => Point(center.x, center.y + verticalOffset / 2);
}
