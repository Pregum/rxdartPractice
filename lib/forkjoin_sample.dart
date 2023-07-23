import 'package:rxdart/rxdart.dart';

/// rxdartのForkJoinオペレータ
void studyForkJoinTwo() {
  Rx.forkJoin2(
    Stream.value(1),
    Stream.fromIterable([0, 2, 4]),
    (int a, int b) => a + b,
  ).listen(
    print,
    onDone: () => print('done'),
  );
}

/// rxdartのForkJoinオペレータその2
void studyForkJoinTwo2() async {
  PublishSubject<int> ps1 = PublishSubject<int>();
  PublishSubject<int> ps2 = PublishSubject<int>();

  Rx.forkJoin2<int, int, int>(
    ps1.stream,
    ps2.stream,
    (ps1, ps2) {
      print('ps1: $ps1 + ps2: $ps2 = ${ps1 + ps2}');
      return ps1 + ps2;
    },
  ).listen(
    (val) => print('listen: $val'),
    onDone: () => print('done.'),
  );

  print('ps1 onNext -- 1');
  ps1.add(1);
  print('ps2 onNext -- 11');
  ps2.add(11);
  print('ps2 onNext -- 12');
  ps2.add(12);
  print('ps2 onNext -- 13');
  ps2.add(13);
  print('ps1 onNext -- 2');
  ps1.add(2);
  await ps1.close();
  await ps2.close();
}

/// Stream APIのForkJoinオペレータ
void studyForkJoinTwoStream() {
  ForkJoinStream.combine2(
    Stream.value(1),
    Stream.fromIterable([0, 2, 4]),
    (int a, int b) => a + b,
  ).listen(
    print,
    onDone: () => print('done.'),
  );
}
