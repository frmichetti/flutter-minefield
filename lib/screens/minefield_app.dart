import 'package:flutter/material.dart';
import 'package:minefield/components/result_widget.dart';
import 'package:minefield/components/field_widget.dart';
import 'package:minefield/models/explosion_exception.dart';
import 'package:minefield/models/field.dart';

class MineFieldApp extends StatelessWidget {

  void _restart() {
    print("Clickou aqui");
  }

  void _open(Field field) {
    print("Clickou em Abrir");
  }

  void _swapMark(Field field) {
    print("Clickou em Trocar marcação");
  }



  @override
  Widget build(BuildContext context) {
    Field field = Field(line: 0, column: 0);
    Field field2 = Field(line: 1, column: 0);
    field2.doMine();
    field.addNeighbor(field2);

    try{
      field.changeMark();
    }on ExplosionException {

    }

    return MaterialApp(
      home: Scaffold(
        appBar: ResultWidget(
          win: null,
          onRestart: _restart,
        ),
          body: Container(
          child: FieldWidget(
            field: field,
            onOpen: _open,
            onSwapMark: _swapMark,
          ),
      ),
      )
    );
  }

}