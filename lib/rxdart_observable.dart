import 'dart:async';

import 'package:rxdart/rxdart.dart';

void studyObservable() {
  final Stream<String> observable = Rx.concat<String>([
    Stream<String>.fromIterable(<String>['hello', 'rxdart.']),
    Stream<String>.value('just constructor'),
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
  final Stream<int> observable =
      Rx.concat<int>([Stream<int>.value(4), Rx.range(5, 7)]);
  // Observableのmap(内部ではStream.mapを使用)を適用し、購読者を登録
  var rxObserver = observable
      .map((i) => 'observable value: $i')
      .listen((i) => print(i), onDone: () => print('done.'))
        // 購読者のonDoneメソッドを使用することでStreamが閉じた時の処理を記述できます。
        // 購読時にもonDone引数を記述していた場合、こちらが優先されます。
        ..onDone(() => print('rxObserver done.'));
}

void studyJustValue() {
  // 単一の値を含むStreamを作成
  final Stream<String> stream = Stream.value('stream.value');
  print('subscriber create.');
  // 購読者を登録してから値が発行される。
  var streamSubscriber =
      stream.listen(print, onDone: () => print('stream.value done.'));
}

void studyRepeat() {
  // 指定された回数分Streamを作成するStreamを作成
  final Stream<String> repeatStream = RepeatStream<String>(
      (int repeatIndex) => Stream.value('st count: $repeatIndex'), 3);
  // 指定された回数分Observableを作成するObservableを作成
  final Stream<String> repeatObservable = Rx.repeat(
      (int repeatIndex) => Stream.value('ob count: $repeatIndex'), 3);
  print('subscriber create.');

  var streamSubscriber =
      repeatStream.listen(print, onDone: () => print('RepeatStream done.'));
  var observableSubscriber = repeatObservable.listen(print,
      onDone: () => print('Rx.repeat done.'));
}
// 実行結果
// subscriber create.
// st count: 0
// ob count: 0
// st count: 1
// ob count: 1
// st count: 2
// ob count: 2
// RepeatStream done.
// Rx.repeat done.

void studyRange() async {
  // 指定された範囲内の整数のシーケンスを発行するStreamを作成
  final Stream<int> rangeStream = RangeStream(1, 3);
  // 指定された範囲内の整数のシーケンスを発行するObservableを作成
  final Stream<int> rangeObservable = Rx.range(1, 3);
  print('subscriber create.');
  var streamSubscriber = rangeStream.listen((i) => print('stream: $i'),
      onDone: () => print('RangeStream done.'));
  var observableSubscriber = rangeObservable.listen(
      (i) => print('observable: $i'),
      onDone: () => print('Rx.range done.'));

  // 区切るために少し待つ
  await Future.delayed(Duration(milliseconds: 500));
  print('---------------------');

  // 発行される整数のシーケンスは、第1引数から第2引数に向かって発行される。
  final Stream<int> inverseRangeObservable = Rx.range(3, 1);
  var observableSubscriber2 = inverseRangeObservable.listen(print,
      onDone: () => print('inv Rx.range done.'));
}
// 実行結果
// subscriber create.
// stream: 1
// observable: 1
// stream: 2
// observable: 2
// stream: 3
// observable: 3
// RangeStream done.
// Rx.range done.
// ---------------------
// 3
// 2
// 1
// inv Rx.range done.

void studyError() {
  // エラーを発行するStreamを作成します。
  final Stream<String> errorStream = Stream.error('Stream.error output.');
  print('subscriber create.');

  var streamSubscriber =
      errorStream.listen(print, onError: (e) => print('stream error: $e'));
}
// 実行結果
// subscriber create.
// stream error: Stream.error output.

void studyTimer() async {
  // 指定された時間経過すると、指定された値が発行されるStreamを作成
  final Stream<DateTime> timerStream =
      TimerStream(DateTime.now(), Duration(seconds: 2));
      print('create stream that listen 2sec after.');
  // 指定された時間経過すると、指定された値が発行されるObservablerを作成
  final Stream<DateTime> timerObservable =
      Rx.timer(DateTime.now(), Duration(seconds: 5));
      print('create stream that listen 5sec after.');
  print('now: ${DateTime.now()}');
  // 発行される値は、Stream作成時に作成されている。
  var streamSubscriber = timerStream.listen((dt) => print('st listen: $dt'),
      onDone: () => print('TimerStream done. -- now: ${DateTime.now()}'));
  // 発行される値は、Observable作成時に作成されている。
  var observableSubscriber = timerObservable.listen(
      (dt) => print('ob listen: $dt'),
      onDone: () => print('Rx.timer done. -- now: ${DateTime.now()}'));
}
// 実行結果
// create stream that listen 2sec after.
// create stream that listen 5sec after.
// now: 2020-05-04 10:41:35.083006
// st listen: 2020-05-04 10:41:35.082008
// TimerStream done. -- now: 2020-05-04 10:41:37.097631
// ob listen: 2020-05-04 10:41:35.083006
// Rx.timer done. -- now: 2020-05-04 10:41:40.092854