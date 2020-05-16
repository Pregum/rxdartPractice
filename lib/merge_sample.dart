import 'package:rxdart/rxdart.dart';

// rxdartのMergeオペレータ
void studyMerge() {
  // mergeは一度にすべてのStreamを発行するので、表示される順番はそれぞれのStream次第です。
  // 最初にすべてのStreamが発行されるので、'do on listen.'は最初に表示されます。
  Rx.merge([
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
// listen: 3
// listen: 4
// listen: 2

// Stream APIのMergeオペレータ
void studyMergeStream() {
  MergeStream<int>([
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
// listen: 3
// listen: 4
// listen: 2