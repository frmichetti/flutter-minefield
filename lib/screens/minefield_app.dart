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
  Board _board;

  void _restart() {
    setState(() {
      _win = null;
      _board.restart();
    });
  }

  void _open(Field field) {
    if (_win != null) {
      return;
    }
    setState(() {
      try {
        field.open();
        if (_board.isSolved) {
          _win = true;
        }
      } on ExplosionException {
        _win = false;
        _board.revealMines();
      }
    });
  }

  void _swapMark(Field field) {
    if (_win != null) {
      return;
    }
    setState(() {
      field.changeMark();
      if (_board.isSolved) {
        _win = true;
      }
    });
  }

  Board _getBoard(double height, double width) {
    if (_board == null) {
      int amountColumns = 15;
      double sizeOfField = width / amountColumns;
      int amountLines = (height / sizeOfField).floor();

      _board =
          Board(lines: amountLines, columns: amountColumns, amoutOfMines: 30);
    }
    return _board;
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
        color: Colors.grey,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return BoardWidget(
                board: _getBoard(constraints.maxHeight, constraints.maxWidth),
                onOpen: _open,
                onSwapMark: _swapMark);
          },
        ),
      ),
    ));
  }
}
