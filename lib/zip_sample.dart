import 'dart:async';
import 'package:rxdart/rxdart.dart';

/// rxdartのZipオペレータ
void studyZipTwo() async {
  PublishSubject<int> ps1 = PublishSubject<int>();
  PublishSubject<int> ps2 = PublishSubject<int>();
  
  Rx.zip2(
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
  await ps1.add(1);
  print('ps2 onNext -- 11');
  await ps2.add(11);
  print('ps2 onNext -- 12');
  await ps2.add(12);
  print('ps2 onNext -- 13');
  await ps2.add(13);
  print('ps1 onNext -- 2');
  await ps1.add(2);
  await ps1.close();
  await ps2.close();
}
  
/// rxdartのForkJoinオペレータ
void studyZipList() {
  Rx.zipList([
    Stream.fromIterable(['a']),
    Stream.fromIterable(['b']),
    Stream.fromIterable(['c', 'd', 'e']),
  ]).listen(
    print,
    onDone: () => print('done'),
  );
}
  
/// Stream APIのZipオペレータ
void studyZipTwoStream() async {
  StreamController<int> ps1 = StreamController<int>();
  StreamController<int> ps2 = StreamController<int>();
  
  ZipStream.zip2(
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
  await ps1.add(1);
  print('ps2 onNext -- 11');
  await ps2.add(11);
  print('ps2 onNext -- 12');
  await ps2.add(12);
  print('ps2 onNext -- 13');
  await ps2.add(13);
  print('ps1 onNext -- 2');
  await ps1.add(2);
  await ps1.close();
  await ps2.close();
}
