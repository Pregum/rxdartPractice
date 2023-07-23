import 'package:rxdart/rxdart.dart';

Future studyConcatWith() async {
  // 1のstreamを発行
  Stream.value(1)
      // 複数のstreamを順番に追加していく
      .concatWith([
    // 0~4までのstreamを発行
    Stream.periodic(Duration(milliseconds: 100), (int i) => i).take(5),
    // 5~9までのstreamを発行
    Stream.periodic(Duration(milliseconds: 100), (int i) => i).skip(5).take(5),
  ]).listen(print, onDone: () => print('on done.'));
}
