import 'package:rxdart/rxdart.dart';

// rxdartのConcatオペレータ
void studyConcat() {
  // concatは実行中のStreamが完了するまで、次のStreamが購読されないため
  // 'do on listen.'は3つ目のStreamが完了してから表示されます。
  // timerを使用してもその秒数待った後、順番に出力されます。
  Rx.concat<int>([
    Stream<int>.value(1),
    // Stream<int>.timer(2, Duration(seconds: 2)),
    Rx.timer(2, Duration(seconds: 2)),
    Stream<int>.value(3),
    Rx.timer(4, Duration(seconds: 1))
        .doOnListen(() => print('do on listen.')),
  ]).listen((i) => print('listen: $i'));
}
// 実行結果
// listen: 1
// listen: 2
// listen: 3
// do on listen.
// listen: 4

// Stream APIのconcatオペレータ
void studyConcatStream() {
  ConcatStream<int>([
    Stream<int>.value(1),
    TimerStream<int>(2, Duration(seconds: 2)),
    Stream<int>.value(3),
    TimerStream<int>(4, Duration(seconds: 1))
        .transform(DoStreamTransformer(onListen: () => print('do on listen.'))),
  ]).listen((i) => print('listen: $i'));
}
// 実行結果
// listen: 1
// listen: 2
// listen: 3
// do on listen.
// listen: 4

