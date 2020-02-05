import 'package:rxdart/rxdart.dart';

/// rxdartのRetryオペレータサンプル
void studyRetry() async {
  // 正常に値が処理された場合は、そのまま完了処理が行われる。
  Observable<int>.retry(() => Observable<int>.just(1))
      .listen(print, onDone: () => print('done.'));

  // 間をあけるため、少し待つ
  await Future.delayed(Duration(milliseconds: 500));
  print('-----');

  // 指定された回数失敗した時のStreamでRetryErrorが発行される。
  // 今回は2を指定しているため、3回目の失敗でRetryErrorが発行される。
  var val = 1;
  Observable<int>.retry(
          () => Observable<int>.just(val++)
              .concatWith([Observable<int>.error(Error())]),
          2)
      .listen((x) => print('listen: $x'),
          onDone: () => print('done.'),
          onError: (e, s) => print('error: $e'),
          cancelOnError: true);
}

/// Stream APIのRetryオペレータサンプル
void studyRetryStream() async {
  RetryStream<int>(() => Stream<int>.value(1))
      .listen(print, onDone: () => print('done.'));
  
  await Future.delayed(Duration(milliseconds: 500));
  print('-----');
  
  var val = 1;
  RetryStream<int>(
          () => ConcatStream(
              [Stream<int>.value(val++), ErrorStream<int>(Error())]),
          2)
      .listen(
    (x) => print('listen: $x'),
    onDone: () => print('done.'),
    onError: (e, s) => print('error: $e'),
    cancelOnError: true,
  );
}
