import 'package:flutter/material.dart';
import 'package:minefield/components/result_widget.dart';

class MineFieldApp extends StatelessWidget {

  _restart() {
    print("Clickou aqui");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: ResultWidget(
          win: null,
          onRestart: _restart,
        ),
          body: Container(
          child: Text("Board"),
      ),
      )
    );
  }

}