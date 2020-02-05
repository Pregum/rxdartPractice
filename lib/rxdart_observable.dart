import 'dart:async';

import 'package:rxdart/rxdart.dart';

void studyObservable() {
  final Observable<String> observable = Observable<String>.concat([
    Observable<String>.fromIterable(<String>['hello', 'rxdart.']),
    Observable<String>.just('just constructor'),
  ]);
  var subscriber1 = observable.listen(print);
}

void studyStream() {
  // Dart Streamを使用した例
  final Stream<int> stream = Stream.fromIterable(<int>[1, 2, 3, 4]);
  // Stream.mapを適用(4というintを'map: 4'という文字列に変換)し、購読者を登録
  var streamObserver =
      stream.map((i) => 'stream value: $i').last.asStream().listen(print);

  // rxdartのObservable<T>を使用した例
  final Observable<int> observable =
      Observable<int>.concat([Observable<int>.just(4), Observable.range(5, 7)]);
  // Observableのmap(内部ではStream.mapを使用)を適用し、購読者を登録
  var rxObserver = observable
      .map((i) => 'observable value: $i')
      .listen((i) => print(i), onDone: () => print('done.'))
        // 購読者のonDoneメソッドを使用することでStreamが閉じた時の処理を記述できます。
        // 購読時にもonDone引数を記述していた場合、こちらが優先されます。
        ..onDone(() => print('rxObserver done.'));
}

void studyJustV() {
  // 単一の値を含むStreamを作成
  final Stream<String> stream = Stream.value('stream.value');
  // 単一の値を含むObservableを作成
  final Observable<String> observable = Observable.just('observable.just');
  print('subscriber create.');
  // 購読者を登録してから値が発行される。
  var streamSubscriber =
      stream.listen(print, onDone: () => print('stream.value done.'));
  var observableSubscriber =
      observable.listen(print, onDone: () => print('observable.just done.'));
}

void studyRepeat() {
  // 指定された回数分Streamを作成するStreamを作成
  final Stream<String> repeatStream = RepeatStream<String>(
      (int repeatIndex) => Stream.value('st count: $repeatIndex'), 3);
  // 指定された回数分Observableを作成するObservableを作成
  final Observable<String> repeatObservable = Observable.repeat(
      (int repeatIndex) => Observable.just('ob count: $repeatIndex'), 3);
  print('subscriber create.');

  var streamSubscriber =
      repeatStream.listen(print, onDone: () => print('RepeatStream done.'));
  var observableSubscriber = repeatObservable.listen(print,
      onDone: () => print('Observable.repeat done.'));
}

void studyRange() async {
  // 指定された範囲内の整数のシーケンスを発行するStreamを作成
  final Stream<int> rangeStream = RangeStream(1, 3);
  // 指定された範囲内の整数のシーケンスを発行するObservableを作成
  final Observable<int> rangeObservable = Observable.range(1, 3);
  print('subscriber create.');
  var streamSubscriber = rangeStream.listen((i) => print('stream: $i'),
      onDone: () => print('RangeStream done.'));
  var observableSubscriber = rangeObservable.listen(
      (i) => print('observable: $i'),
      onDone: () => print('Observable.range done.'));

  // 区切るために少し待つ
  await Future.delayed(Duration(milliseconds: 500));
  print('---------------------');

  // 発行される整数のシーケンスは、第1引数から第2引数に向かって発行される。
  final Observable<int> inverseRangeObservable = Observable.range(3, 1);
  var observableSubscriber2 = inverseRangeObservable.listen(print,
      onDone: () => print('Observable.range done.'));
}

void studyError() {
  // エラーを発行するStreamを作成します。
  final Stream<String> errorStream = ErrorStream('ErrorStream output.');
  // エラーを発行するObservableを作成します。
  final Observable<String> errorObservable =
      Observable.error(Exception('Observable.error output.'));
  print('subscriber create.');

  var streamSubscriber =
      errorStream.listen(print, onError: (e) => print('stream error: $e'));
  var observableSubscriber = errorObservable.listen(print,
      onError: (e) => print('observable occurs: $e'));
}

void studyTimer() async {
  // 指定された時間経過すると、指定された値が発行されるStreamを作成
  final Stream<DateTime> timerStream =
      TimerStream(DateTime.now(), Duration(seconds: 1));
  // 指定された時間経過すると、指定された値が発行されるObservablerを作成
  final Observable<DateTime> timerObservable =
      Observable.timer(DateTime.now(), Duration(seconds: 1));
  print('now: ${DateTime.now()}');
  // 発行される値は、Stream作成時に作成されている。
  var streamSubscriber = timerStream.listen((dt) => print('st listen: $dt'),
      onDone: () => print('TimerStream done.'));
  // 発行される値は、Observable作成時に作成されている。
  var observableSubscriber = timerObservable.listen(
      (dt) => print('ob listen: $dt'),
      onDone: () => print('Observable.timer done.'));
  await Future.delayed(Duration(seconds: 1));
  print('now: ${DateTime.now()}');
}