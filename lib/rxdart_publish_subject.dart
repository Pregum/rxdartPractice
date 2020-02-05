import 'dart:async';
import 'package:rxdart/rxdart.dart';

void studySubject() {
  // StreamControllerを生成
  final StreamController<String> sc = StreamController<String>();
  // StreamControllerのstream
  final scStream = sc.stream;
  // StreamControllerのsink
  final scSink = sc.sink;
  // Streamの購読者を登録する
  var scSubscriber = scStream.listen((str) => print('sc listen: $str'));

  // Streamの値を発行する
  scSink.add('hi StreamController.');
  // この書き方も可能
  // sc.add('hi StreamController.');

  // StreamControllerとほぼ同じ動きをするPublishSubjectを生成
  final PublishSubject<String> subject = PublishSubject<String>();
  // PublishSubjectのstream
  final subjStream = subject.stream;
  // PublishSubjectのsink
  final subjSink = subject.sink;
  // Observableの購読者を登録する
  var subjSubscriber = subjStream.listen((str) => print('subj listen: $str'));

  // Observableの値を発行する
  subjSink.add('hi subject.');
  // この書き方も可能
  // subject.add('hi subject.');
}

void studyPublishSubject() {
  // PublishSubjectを作成
  final PublishSubject<int> subject = PublishSubject<int>();

  // 値1を発行。この時点では購読者がいないため、何も処理されない
  subject.add(1);
  // ここで、購読者1を登録
  var subscriber1 = subject.stream.listen((val) => print('sub1 listen: $val'));
  // 値2を発行。購読者1が登録されているため処理が行われる。
  subject.add(2);
  // 購読者2を登録
  var subscriber2 = subject.stream.listen((val) => print('sub2 listen: $val'));
  // 値3を発行。購読者1, 2が登録されている為、それぞれ処理が行われる。
  subject.add(3);
  // streamを閉じる。
  subject.close();
}

void studyBehaviorSubject() async {
  // BehaviorSubject(初期値なし)を作成
  final BehaviorSubject<int> subject = BehaviorSubject<int>();

  // 初期値がない場合は、初期値では何に購読されない。
  var subscriber1 = subject.stream.listen((val) => print('sub1 listen: $val'));
  subject.add(1);
  subject.add(2);
  // 購読登録時の最新の値が最初に購読される。
  var subscriber2 = subject.stream.listen((val) => print('sub2 listen: $val'));
  await subject.close();

  // 区切り線
  print('------------- ');

  // BehaviorSubject(初期値あり)を作成
  final BehaviorSubject<int> subjectWithSeed = BehaviorSubject<int>.seeded(0);
  // 初期値がある場合は、初期値が最初に購読される。
  var subscriber3 =
      subjectWithSeed.stream.listen((val) => print('sub3 listen: $val'));
  subjectWithSeed.add(1);
  subjectWithSeed.add(2);
  var subscriber4 =
      subjectWithSeed.stream.listen((val) => print('sub4 listen: $val'));
  await subjectWithSeed.close();
}

void studyReplaySubject() async {
  // ReplaySubjectを発行(制限なし)
  final ReplaySubject<int> subject = ReplaySubject<int>();

  // 値1を発行
  subject.add(1);
  subject.add(2);
  // 購読登録時の出力される値をすべて取得するので、値1と値2を購読する
  var subscriber1 = subject.stream.listen((val) => print('sub1 listen: $val'));
  // 値3を発行
  subject.add(3);
  // 購読登録時の出力される値をすべて取得するので、値1と値2と値3を購読する
  var subscriber2 = subject.stream.listen((val) => print('sub2 listen: $val'));
  await subject.close();

  // 区切る為に少し待機
  await Future.delayed(Duration(milliseconds: 500));
  print('--------------------');

  // ReplaySubjectを発行(制限あり:2)
  final ReplaySubject<int> limitedSubject = ReplaySubject<int>(maxSize: 2);

  // 値1を発行
  limitedSubject.add(1);
  limitedSubject.add(2);
  // 購読登録時の出力される値を最大2つまで保持するので、値1, 値2を購読する
  var subscriber3 =
      limitedSubject.stream.listen((val) => print('sub3 listen: $val'));
  // 値3を発行
  limitedSubject.add(3);
  // この時点で値1は破棄されるので、値2, 値3を購読する
  var subscriber4 =
      limitedSubject.stream.listen((val) => print('sub4 listen: $val'));
  await limitedSubject.close();
}

void studyAsyncSubject() {
  var subject = PublishSubject<int>();
  var asyncStream = Observable.fromFuture(subject.last);

  subject
    ..add(1)
    ..add(2)
    ..add(3)
    ..close();
  // 最後の値のみ購読する。
  asyncStream.listen(print);
}

