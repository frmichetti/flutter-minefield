import 'dart:math';

import 'field.dart';
import 'package:flutter/foundation.dart';

class Board {
  final int lines;
  final int columns;
  final int amoutOfMines;

  final List<Field> _fields = [];

  Board({
    @required this.lines,
    @required this.columns,
    @required this.amoutOfMines
}){
    _createFields();
    _connectNeighbors();
    _sortMines();
  }

  void restart() {
    _fields.forEach((f) => f.restart());
    _sortMines();
  }

  void revealMines() {
    _fields.forEach((f) => f.revealBombs());
  }

  void _createFields(){
    for(int l = 0;l < lines; l++){
      for(int c = 0;c < columns; c++){
        _fields.add(Field(line: l, column: c));
      }
    }
  }

  void _connectNeighbors() {
    for(var field in _fields){
      for(var neighbor in _fields){
        field.addNeighbor(neighbor);
      }
    }
  }

  void _sortMines(){
    int sorted = 0;

    if(amoutOfMines > lines * columns){
      return;
    }

    while(sorted < amoutOfMines){
      int i = Random().nextInt(_fields.length);

      if(!_fields[i].isMined){
        sorted++;
        _fields[i].doMine();
      }
    }
  }

  List<Field> get fields {
    return _fields;
  }

  bool get solved {
    return _fields.every((f) => f.isSolved);
  }

}

