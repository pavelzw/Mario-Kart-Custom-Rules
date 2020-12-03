import 'dart:math';

import 'package:mariokartcustomrules/views/layout_strategies/layout_strategy.dart';

class GridLayout extends LayoutStrategy {
  GridLayout(double screenWidth, double screenHeight, int amountOfPositions)
      : super(screenWidth, screenHeight, amountOfPositions);

  @override
  Point<num> centerPosition() {
    // TODO: implement centerPosition
    throw UnimplementedError();
  }

  @override
  Point<num> getPosition(int position) {
    // TODO: implement getPosition
    throw UnimplementedError();
  }
}
