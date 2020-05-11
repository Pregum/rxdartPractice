import 'package:rxdart/rxdart.dart';

// rxdartのMergeオペレータサンプル
void studyMerge() {
  // mergeは一度にすべてのObservableな値を発行するので、表示される順番はそれぞれのObservableな値次第です。
  // 最初にすべてのObservableな値が発行されるので、'do on listen.'は最初に表示されます。
  Rx.merge([
    Stream.value(1),
    Rx.timer(2, Duration(seconds: 2)),
    Stream.value(3),
    Rx.timer(4, Duration(seconds: 1))
        .doOnListen(() => print('do on listen.')),
  ]).listen((i) => print('listen: $i'));
}

// Stream APIのMergeオペレータサンプル
void studyMergeStream() {
  MergeStream<int>([
    Stream<int>.value(1),
    TimerStream<int>(2, Duration(seconds: 2)),
    Stream<int>.value(3),
    TimerStream<int>(4, Duration(seconds: 1))
        .transform(DoStreamTransformer(onListen: () => print('do on listen.'))),
  ]).listen((i) => print('listen: $i'));
}