import 'package:rxdart/rxdart.dart';

/// rxdartのRace(Amb)オペレータ
void studyRace() {
  // 複数のStreamの内一番最初に作成されたStreamを発行し
  // それ以外のStreamは発行しません
  Observable<int>.race([
    Observable<int>.timer(1, Duration(seconds: 2)),
    Observable<int>.timer(2, Duration(seconds: 1)),
    Observable<int>.timer(3, Duration(seconds: 3)),
  ]).listen(print, onDone: () => print('done.'));
}
// 実行結果
// 2
// done.
  
/// Stream APIのRace(Amb)オペレータ
void studyRaceStream() {
  RaceStream<int>([
    TimerStream<int>(1, Duration(seconds: 2)),
    TimerStream<int>(2, Duration(seconds: 1)),
    TimerStream<int>(3, Duration(seconds: 3)),
  ]).listen(print, onDone: () => print('done.'));
}
// 実行結果
// 2
// done.
