import 'package:flutter/material.dart';

class ResultWidget extends StatelessWidget implements PreferredSizeWidget {
  final bool win;
  final Function onRestart;

  ResultWidget({@required this.win, @required this.onRestart});

  Color _getColor() {
    if (win == null) {
      return Colors.yellow;
    } else if (win == false) {
      return Colors.red[300];
    } else {
      return Colors.green[300];
    }
  }

  IconData _getIcon() {
    if (win == null) {
      return Icons.sentiment_satisfied;
    } else if (win == false) {
      return Icons.sentiment_very_dissatisfied;
    } else {
      return Icons.sentiment_very_satisfied;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: Container(
        padding: EdgeInsets.all(10),
        child: CircleAvatar(
          backgroundColor: _getColor(),
          child: IconButton(
            padding: EdgeInsets.all(0),
            icon: Icon(
                _getIcon(),
              color: Colors.black,
              size: 35,
            ),
            onPressed: onRestart,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(120);
}
