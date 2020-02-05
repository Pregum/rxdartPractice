import 'package:rxdart/rxdart.dart';

Future studyBufferCount() async {

  // 1から4の値を発行するストリームを生成する
  Observable.range(1, 4)
  // 購読したストリームから2要素取得する
  .bufferCount(2)
  // 購読する
  .listen(print);

  // 区切る為に少し待つ
  await Future.delayed(const Duration(milliseconds: 500));
  print('--------------------------------------------------');

  // 1から10の値を発行するストリームを生成する
  Observable.range(1, 10)
  // 購読したストリームから5要素取得し、古いストリームから2要素だけ進めたストリームを生成する
  .bufferCount(5, 2)
  // 購読する
  .listen(print);

  // 区切る為に少し待つ
  await Future.delayed(const Duration(milliseconds: 500));
  print('--------------------------------------------------');

  // 1から10の値を発行するストリームを生成する
  Observable.range(1, 10)
  // 購読したストリームから2要素取得し、古いストリームから5要素進めたストリームを生成する
  .bufferCount(2, 5)
  // 購読する
  .listen(print);
}
// 実行結果
// [1, 2]
// [3, 4]
// --------------------------------------------------
// [1, 2, 3, 4, 5]
// [3, 4, 5, 6, 7]
// [5, 6, 7, 8, 9]
// [7, 8, 9, 10]
// --------------------------------------------------
// [1, 2]
// [6, 7]

Future studyBufferCountStreamTransformer() async {
  // 1から4の値を発行するストリームを生成する
  RangeStream(1, 4)
  // 購読したストリームから2要素取得する
  .transform(BufferCountStreamTransformer(2))
  // 購読する
  .listen(print);

  // 区切る為に少し待つ
  await Future.delayed(const Duration(milliseconds: 500));
  print('--------------------------------------------------');

  // 1から10の値を発行するストリームを生成する
  RangeStream(1,10)
  // 購読したストリームから5要素取得し、古いストリームから2要素だけ進めたストリームを生成する
  .transform(BufferCountStreamTransformer(5, 2))
  // 購読する
  .listen(print);

  // 区切る為に少し待つ
  await Future.delayed(const Duration(milliseconds: 500));
  print('--------------------------------------------------');

  // 1から10の値を発行するストリームを生成する
  RangeStream(1, 10)
  // 購読したストリームから2要素取得し、古いストリームから5要素進めたストリームを生成する
  .transform(BufferCountStreamTransformer(2, 5))
  // 購読する
  .listen(print);
}
//　実行結果
// [1, 2]
// [3, 4]
// --------------------------------------------------
// [1, 2, 3, 4, 5]
// [3, 4, 5, 6, 7]
// [5, 6, 7, 8, 9]
// [7, 8, 9, 10]
// --------------------------------------------------
// [1, 2]
// [6, 7]
