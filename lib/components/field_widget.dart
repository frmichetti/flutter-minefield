import 'package:flutter/material.dart';
import 'package:minefield/models/field.dart';

class FieldWidget extends StatelessWidget {
  final Field field;
  final void Function(Field) onOpen;
  final void Function(Field) onSwapMark;

  FieldWidget(
      {@required this.field, @required this.onOpen, @required this.onSwapMark});

  Widget _getImage() {
    int amountMines = field.amountMinesNeighbor;
    if (field.isOpened && field.isMined && field.isExploded) {
      return Image.asset("assets/images/bomba_0.jpeg");
    } else if (field.isOpened && field.isMined) {
      return Image.asset("assets/images/bomba_1.jpeg");
    } else if (field.isOpened) {
      return Image.asset("assets/images/aberto_$amountMines.jpeg");
    } else if (field.isMarked) {
      return Image.asset("assets/images/bandeira.jpeg");
    } else {
      return Image.asset("assets/images/fechado.jpeg");
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onOpen(field),
      onLongPress: () => onSwapMark(field),
      child: _getImage(),
    );
  }
}
