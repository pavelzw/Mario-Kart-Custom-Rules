import 'dart:math';

import 'package:mariokartcustomrules/views/layout_strategies/layout_strategy.dart';

class GridLayout extends LayoutStrategy {
  final double tileSize;

  GridLayout(this.tileSize, double screenWidth, double screenHeight, int amountOfPositions)
      : super(screenWidth, screenHeight, amountOfPositions);

  int get topRowAmount {
    if (amountOfPositions >= 12) {
      return ((amountOfPositions - 4) / 2).ceil();
    }
    return ((amountOfPositions - 2) / 2).ceil();
  }

  int get middleAmount {
    return amountOfPositions >= 12 ? 2 : 1;
  }

  int get bottomAmount {
    if (amountOfPositions >= 12) {
      return ((amountOfPositions - 4) / 2).floor();
    }
    return ((amountOfPositions - 2) / 2).floor();
  }

  double get gutterSize => tileSize * 0.08;

  double leftBorder(amountInRow) => (screenWidth - amountInRow * tileSize - (amountInRow - 1) * gutterSize) / 2;

  Point _getRowPosition(int horizontalIndex, int horizontalAmount, int verticalLayer) {
    return Point(leftBorder(horizontalAmount) + tileSize / 2 + horizontalIndex * (tileSize + gutterSize),
        center.y + verticalLayer * (tileSize + gutterSize));
  }

  @override
  Point<num> centerPosition() {
    return center;
  }

  @override
  Point<num> getPosition(int position) {
    if (position < topRowAmount) {
      return _getRowPosition(position, topRowAmount, -1);
    }
    if (position < topRowAmount + middleAmount) {
      return _getRowPosition(position - topRowAmount, middleAmount * 2 + 1, 0);
    }
    // skip center piece
    if (position < topRowAmount + 2 * middleAmount) {
      return _getRowPosition(position - topRowAmount + 1, middleAmount * 2 + 1, 0);
    }
    return _getRowPosition(position - topRowAmount - 2 * middleAmount, bottomAmount, 1);
  }
}
