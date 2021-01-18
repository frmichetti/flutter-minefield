import 'package:flutter/material.dart';
import 'package:minefield/components/board_widget.dart';
import 'package:minefield/components/result_widget.dart';
import 'package:minefield/components/field_widget.dart';
import 'package:minefield/models/board.dart';
import 'package:minefield/models/explosion_exception.dart';
import 'package:minefield/models/field.dart';

class MineFieldApp extends StatefulWidget {
  @override
  _MineFieldAppState createState() => _MineFieldAppState();
}

class _MineFieldAppState extends State<MineFieldApp> {
  bool _win;
  Board _board = Board(lines: 12, columns: 12, amoutOfMines: 3);

  void _restart() {
    setState(() {
      _win = null;
      _board.restart();
    });
  }

  void _open(Field field) {
    if (_win != null){
      return;
    }
    setState(() {
      try {
        field.open();
        if(_board.isSolved){
          _win= true;

        }
      } on ExplosionException {
        _win = false;
        _board.revealMines();
      }
    });
  }

  void _swapMark(Field field) {
    if (_win != null){
      return;
    }
    setState(() {
      field.changeMark();
      if (_board.isSolved){
        _win = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: ResultWidget(
        win: _win,
        onRestart: _restart,
      ),
      body: Container(
        child: BoardWidget(
          board: _board,
          onOpen: _open,
          onSwapMark: _swapMark,
        ),
      ),
    ));
  }
}
