import 'package:rxdart/rxdart.dart';

void studyConcatEager() {
  Observable<int>.concatEager([
    Observable<int>.just(1),
    Observable<int>.timer(2, Duration(seconds: 2)),
    Observable<int>.just(3),
    Observable<int>.timer(4, Duration(seconds: 1))
        .doOnListen(() => print('do on listen.')),
  ]).listen((i) => print('listen: $i'));
}

void studyConcatEagerStream() {
  ConcatEagerStream<int>([
    Stream<int>.value(1),
    TimerStream<int>(2, Duration(seconds: 2)),
    Stream<int>.value(3),
    TimerStream<int>(4, Duration(seconds: 1))
        .transform(DoStreamTransformer(onListen: () => print('do on listen.'))),
  ]).listen((i) => print('listen: $i'));
}
