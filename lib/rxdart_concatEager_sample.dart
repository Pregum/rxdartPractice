import 'package:rxdart/rxdart.dart';

void studyConcatEager() {
  Rx.concatEager<int>([
    Stream.value(1),
    Rx.timer(2, Duration(seconds: 2)),
    Stream.value(3),
    Rx.timer(4, Duration(seconds: 1))
        .doOnListen(() => print('do on listen.')),
  ]).listen((i) => print('listen: $i'));
}
// 実行結果
// do on listen.
// listen: 1
// listen: 2
// listen: 3
// listen: 4
  
void studyConcatEagerStream() {
  ConcatEagerStream<int>([
    Stream<int>.value(1),
    TimerStream<int>(2, Duration(seconds: 2)),
    Stream<int>.value(3),
    TimerStream<int>(4, Duration(seconds: 1))
        .transform(DoStreamTransformer(onListen: () => print('do on listen.'))),
  ]).listen((i) => print('listen: $i'));
}
// 実行結果
// do on listen.
// listen: 1
// listen: 2
// listen: 3
// listen: 4