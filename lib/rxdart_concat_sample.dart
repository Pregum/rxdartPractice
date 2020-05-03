import 'package:rxdart/rxdart.dart';

void studyConcat() {
  // concatは実行中のObservableが完了するまで、次のObservableが購読されないため
  // 'do on listen.'は3つ目のObservableが完了してから表示されます。
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

void studyConcatStream() {
  ConcatStream<int>([
    Stream<int>.value(1),
    TimerStream<int>(2, Duration(seconds: 2)),
    Stream<int>.value(3),
    TimerStream<int>(4, Duration(seconds: 1))
        .transform(DoStreamTransformer(onListen: () => print('do on listen.'))),
  ]).listen((i) => print('listen: $i'));
}
