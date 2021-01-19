import 'package:flutter/cupertino.dart';
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
  final navigatorKey = GlobalKey<NavigatorState>();

  bool _win;
  Board _board;
  int _amountOfMines = 30;

  void _restart(int amountOfMines) {
    setState(() {
      _win = null;
      _board.restart(amountOfMines);
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

  Board _getBoard(double height, double width, int amountOfMines) {
    if (_board == null) {
      int amountColumns = 15;
      double sizeOfField = width / amountColumns;
      int amountLines = (height / sizeOfField).floor();

      _board =
          Board(lines: amountLines, columns: amountColumns, amoutOfMines: amountOfMines);
    }
    return _board;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: navigatorKey,
        theme: ThemeData(
          primaryColor: Colors.grey[800],
          accentColor: Colors.grey[600],
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text("MineField"),
            actions: [
              IconButton(
                  icon: Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                  onPressed: () =>
                      testAlert(navigatorKey.currentState.overlay.context)),
            ],
          ),
          body: Column(
            children: [
              gameBar(),
              Expanded(
                  child: Container(
                color: Colors.grey,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return boardGame(constraints, _amountOfMines);
                  },
                ),
              ))
            ],
          ),
        ));
  }

  Widget gameBar() {
    return ResultWidget(
      win: _win,
      onRestart: () =>_restart(_amountOfMines),
    );
  }

  Widget boardGame(constraints, amountOfMines) {
    return BoardWidget(
        board: _getBoard(constraints.maxHeight, constraints.maxWidth,  amountOfMines),
        onOpen: _open,
        onSwapMark: _swapMark);
  }

  void testAlert(BuildContext context) {
    final number = TextEditingController();
    number.text = _amountOfMines.toString();

    var alert = AlertDialog(
      title: Text("How Many Mines ?"),
      content: Container(
          width: 280,
          padding: EdgeInsets.all(10.0),
          child: TextField(
            controller: number,
            autocorrect: true,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: 'Enter Your Number Here'),
          )),
      actions: [
        FlatButton(
          child: Text("OK"),
          onPressed: () {
            var value = number.value.text;
            setState(() {
              _amountOfMines = int.parse(value);
              _board.restart(_amountOfMines);
            });
            Navigator.pop(context);
          },
        ),
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }
}
