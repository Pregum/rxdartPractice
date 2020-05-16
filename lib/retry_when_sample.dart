import 'package:rxdart/rxdart.dart';

/// rxdartのRetryWhenオペレータサンプル
void studyRetryWhen() {
  Rx.retryWhen<int>(
      () => Stream.periodic(Duration(seconds: 1), (i) => (i))
          .map((i) => i == 2 ? throw 'exception' : i), (e, s) {
    print('error catch. ');
    return Rx.timer(
        'random value', Duration(milliseconds: 200));
  }).take(4).listen(print);
}
// 実行結果
// 0
// 1
// error catch. 
// 0
// 1

/// Stream APIのRetryWhenオペレータサンプル
void studyRetryWhenStream() {
  RetryWhenStream<int>(
      () => Stream<int>.periodic(Duration(seconds: 1), (i) => i)
          .map((i) => i == 2 ? throw 'exception' : i), (e, s) {
    print('error catch. ');
    return TimerStream<String>('random value', Duration(milliseconds: 200));
  }).take(4).listen(print);
}
// 実行結果
// 0
// 1
// error catch. 
// 0
// 1