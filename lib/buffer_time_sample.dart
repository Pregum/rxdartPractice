import 'package:rxdart/rxdart.dart';

Future studyBufferTime() async {
  // 100msecごとにカウントアップするストリームを生成する
  Stream.periodic(Duration(milliseconds: 100), (int i) => i)
      // 330msecごとにサンプリングする
      .bufferTime(Duration(milliseconds: 330))
      // 5要素取得する
      .take(5)
      // 購読する
      .listen(print, onDone: () => print('on done.'));

  // 区切る為に少し待つ
  await Future.delayed(const Duration(milliseconds: 2000));
  print('--------------------------------------------------');

  // 500msecごとにカウントアップするストリームを生成する
  Stream.periodic(Duration(milliseconds: 500), (int i) => i)
      // 100msecごとにサンプリングする
      .bufferTime(Duration(milliseconds: 100))
      // 5要素取得する
      .take(5)
      // 購読する
      .listen(print, onDone: () => print('on done.'));
}
// [0, 1, 2, 3]
// [4, 5, 6]
// [7, 8, 9]
// [10, 11, 12, 13]
// [14, 15, 16]
// on done.
// --------------------------------------------------
// [0]
// []
// []
// []
// [1]
// on done.


Future studyBufferTimeStreamTransfor() async {
  Stream.periodic(Duration(milliseconds: 100), (int i) => i)
      .transform(BufferStreamTransformer(
          (int window) => Stream.periodic(Duration(milliseconds: 330))))
      .take(5)
      .listen(print, onDone: () => print('on done.'));

  // 区切る為に少し待つ
  await Future.delayed(const Duration(milliseconds: 2000));
  print('--------------------------------------------------');

  Stream.periodic(Duration(milliseconds: 500), (int i) => i)
      .transform(BufferStreamTransformer(
          (int window) => Stream.periodic(Duration(milliseconds: 100))))
      .take(5)
      .listen(print, onDone: () => print('on done.'));
}
// [0, 1, 2, 3]
// [4, 5, 6]
// [7, 8, 9]
// [10, 11, 12, 13]
// [14, 15, 16]
// on done.
// --------------------------------------------------
// [0]
// []
// []
// []
// [1]
// on done.
