import 'package:rxdart/rxdart.dart';

/// BufferTestのサンプルコード
Future studyBufferTest() async {
  Stream.periodic(Duration(milliseconds: 100), (int i) => i)
      .take(20)
      .bufferTest((i) => i % 2 == 0)
      .listen(print, onDone: () => print('on done.'));

  // 上と下の処理が同時に実行されないよう少し待つ
  await Future.delayed(Duration(milliseconds: 3000));
  print('--------------------');

  Stream.periodic(Duration(milliseconds: 100), (int i) => i)
      .take(11)
      .bufferTest((i) => i % 5 == 0)
      .listen(print, onDone: () => print('on done.'));
}
// 実行結果
// [0]
// [1, 2]
// [3, 4]
// [5, 6]
// [7, 8]
// [9, 10]
// [11, 12]
// [13, 14]
// [15, 16]
// [17, 18]
// [19]
// on done.
// --------------------
// [0]
// [1, 2, 3, 4, 5]
// [6, 7, 8, 9, 10]
// on done.

Future studyBufferTestStreamTransformer() async {
  Stream.periodic(Duration(milliseconds: 100), (i) => i)
      .take(20)
      .transform(BufferTestStreamTransformer((i) => i % 2 == 0))
      .listen(print, onDone: () => print('on done.'));

  // 上下の処理が同時に実行されないよう少し待つ
  await Future.delayed(Duration(milliseconds: 3000));
  print('--------------------');

  Stream.periodic(Duration(milliseconds: 100), (i) => i)
      .take(11)
      .transform(BufferTestStreamTransformer((i) => i % 5 == 0))
      .listen(print, onDone: () => print('on done.'));
}
// [0]
// [1, 2]
// [3, 4]
// [5, 6]
// [7, 8]
// [9, 10]
// [11, 12]
// [13, 14]
// [15, 16]
// [17, 18]
// [19]
// on done.
// --------------------
