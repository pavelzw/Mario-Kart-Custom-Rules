import 'dart:math';

abstract class LayoutStrategy {
  final double screenWidth;
  final double screenHeight;
  final int amountOfPositions;
  Point get center => Point(screenWidth / 2, screenHeight / 2);

  LayoutStrategy(this.screenWidth, this.screenHeight, this.amountOfPositions);

  Point getPosition(int position);

  Point centerPosition();
}
