import 'package:rxdart/rxdart.dart';

/// rxdartのperiodicサンプル
void studyPeriodic() {
  Observable<int>.periodic(Duration(milliseconds: 500), (i) => i + 3)
      .take(5)
      .listen(print, onDone: () => print('done.'));
}

/// periodicをRxの標準オペレータで代替した場合
void imitationPeriodic() {
  Observable<int>.repeat((val) => Observable<int>.just(val))
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
