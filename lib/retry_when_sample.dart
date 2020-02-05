import 'package:rxdart/rxdart.dart';

/// rxdartのRetryWhenオペレータサンプル
void studyRetryWhen() {
  Observable<int>.retryWhen(
      () => Observable<int>.periodic(Duration(seconds: 1), (i) => (i))
          .map((i) => i == 2 ? throw 'exception' : i), (e, s) {
    print('error catch. ');
    return Observable<String>.timer(
        'random value', Duration(milliseconds: 200));
  }).take(4).listen(print);
}

/// Stream APIのRetryWhenオペレータサンプル
void studyRetryWhenStream() {
  RetryWhenStream<int>(
      () => Stream<int>.periodic(Duration(seconds: 1), (i) => i)
          .map((i) => i == 2 ? throw 'exception' : i), (e, s) {
    print('error catch. ');
    return TimerStream<String>('random value', Duration(milliseconds: 200));
  }).take(4).listen(print);
}
