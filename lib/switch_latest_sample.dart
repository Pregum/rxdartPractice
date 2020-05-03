import 'package:rxdart/rxdart.dart';

/// rxdartのSwitchLatestオペレータサンプル
void studySwitchLatest() {
  Rx.switchLatest<String>(
    // 複数のStreamの中から発行するのが遅いStreamを発行します。
    Stream.fromIterable([
      Rx.timer('1', Duration(seconds: 1)),
      Stream.value('2'),
      Rx.timer('3', Duration(milliseconds: 1500)),
      Rx.timer('4', Duration(seconds: 1)),
    ]),
  ).listen(print, onDone: () => print('done.'));
}

void studySwitchLatest2() async {
  final subject = PublishSubject<int>();

  subject.stream
      .switchMap(
        (i) => Stream.periodic(
            Duration(milliseconds: 1000), (val) => (val + 1) * i).take(3),
      )
      .listen((i) => print('${DateTime.now()} -- $i'),
          onDone: () => print('done.'));

  print('start');
  // print('${DateTime.now()}');
  print('onNext 1');
  subject.add(1);
  await Future.delayed(Duration(milliseconds: 2000));
  print('onNext 2');
  subject.add(2);
  await Future.delayed(Duration(milliseconds: 2000));
  print('onNext 3');
  subject.add(3);
  await subject.close();
}

void studySwitchLatest3() async {
  final subject = PublishSubject<String>();
  var latest = Rx.switchLatest(Stream.periodic(
      Duration(milliseconds: 500),
      (val) =>
          '$val').take(3).map((str) =>
      Stream.fromIterable(List<String>.generate(3, (i) => '$str: $i'))));

  subject.stream.listen((l) => print('listen: $l'));

  await subject.addStream(latest);
  await subject.close();
// .listen((val) => print('listen: $val'), onDone: () => print('done.'))
}

void studySwitchLatest4() {
  var list = <String>["a", "b", "c"];
  Rx.switchLatest(Stream.fromIterable(list).map((d) {
    print('listen: $d');
    return Stream.fromIterable([1, 2, 3, 4]);
  })).listen(print);
}

Stream<int> getStream(String v) {
  return Stream.fromIterable([1, 2, 3, 4]);
}

void studySwitchLatestStream() {
  SwitchLatestStream<String>(
    Stream.fromIterable([
      TimerStream('1', Duration(seconds: 1)),
      Stream.value('2'),
      TimerStream('3', Duration(milliseconds: 1500)),
      TimerStream('4', Duration(seconds: 1)),
    ]),
  ).listen(print, onDone: () => print('done.'));
}
