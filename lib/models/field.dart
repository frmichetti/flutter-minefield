import 'package:flutter/foundation.dart';
import 'explosion_exception.dart';

class Field {
  final int line;
  final int column;
  final List<Field> neighbors = [];

  bool _opened = false;
  bool _marked = false;
  bool _mined = false;
  bool _exploded = false;

  Field({@required this.line, @required this.column});

  void addNeighbor(Field neighbor) {
    final lineDelta = (line - neighbor.line).abs();
    final columnDelta = (column - neighbor.column).abs();

    if (lineDelta == 0 && columnDelta == 0) {
      return;
    }

    if (lineDelta <= 1 && columnDelta <= 1) {
      neighbors.add(neighbor);
    }
  }

  void open() {
    if (_opened) {
      return;
    }

    _opened = true;

    if (_mined) {
      _exploded = true;
      throw ExplosionException();
    }

    if (securedNeighbor) {
      neighbors.forEach((n) => n.open());
    }
  }

  void revealBombs() {
    if (_mined) {
      _opened = true;
    }
  }

  void doMine() {
    _mined = true;
  }

  void changeMark() {
    _marked = !_marked;
  }

  void restart() {
    _opened = false;
    _marked = false;
    _mined = false;
    _exploded = false;
  }

  bool get isMined {
    return _mined;
  }

  bool get isExploded {
    return _exploded;
  }

  bool get isOpened {
    return _opened;
  }

  bool get isMarked {
    return _marked;
  }

  bool get isSolved {
    bool minedAndMarked = isMined && isMarked;
    bool securedAndOpened = !isMined && isOpened;
    return minedAndMarked || securedAndOpened;
  }

  int get amountMinesNeighbor {
    return neighbors.where((n) => n.isMined).length;
  }


  bool get securedNeighbor {
    return neighbors.every((n) => !n._mined);
  }
}
