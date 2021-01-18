import 'package:flutter/material.dart';
import 'package:minefield/models/board.dart';
import 'package:minefield/models/field.dart';

import 'field_widget.dart';

class BoardWidget extends StatelessWidget {

  final Board board;
  final void Function(Field) onOpen;
  final void Function(Field) onSwapMark;

  BoardWidget({
    @required this.board,
    @required this.onOpen,
    @required this.onSwapMark
});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        crossAxisCount: board.columns,
        children: board.fields.map((f) {
          return FieldWidget(field: f, onOpen: onOpen, onSwapMark: onSwapMark);
        }).toList(),
      ),

    );
  }

}