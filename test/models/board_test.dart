import 'package:flutter_test/flutter_test.dart';
import 'package:minefield/models/board.dart';

main() {
  test("Win the Game", (){
    Board board = Board(lines: 2, columns: 2, amoutOfMines: 0);

    board.fields[0].doMine();
    board.fields[3].doMine();

    board.fields[0].changeMark();
    board.fields[1].open();
    board.fields[2].open();
    board.fields[3].changeMark();

    expect(board.isSolved, isTrue);

  });
}