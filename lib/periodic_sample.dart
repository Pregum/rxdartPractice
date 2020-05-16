import 'package:rxdart/rxdart.dart';

/// rxdartのperiodicサンプル
void studyPeriodic() {
  Stream.periodic(Duration(milliseconds: 500), (i) => i + 3)
      .take(5)
      .listen(print, onDone: () => print('done.'));
}

/// periodicをRxの標準オペレータで代替した場合
void imitationPeriodic() {
  Rx.repeat((val) => Stream.value(val))
      .interval(Duration(milliseconds: 500))
      .map((val) => 3 + val)
      .take(5)
      .listen(print, onDone: () => print('done. '));
}

/// Stream APIのperiodicサンプル
void studyPeriodicStream() {
  Stream<int>.periodic(Duration(milliseconds: 500), (i) => i + 3)
      .take(5)
      .listen(print, onDone: () => print('done.'));
}
// 実行結果
// 3
// 4
// 5
// 6
// 7
// done.
