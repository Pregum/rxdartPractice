import 'package:rxdart/rxdart.dart';

/// rxdartのCombineLatestオペレータサンプル
void studyCombineLatest() {
  Rx.combineLatest2(
    Stream.value('hello'),
    Stream.fromIterable(['mike', 'jon']),
    (a, b) => '$a $b',
  ).listen(print, onDone: () => print('done.'));
}

/// Stream APIのCombineLatestオペレータサンプル
void studyCombineLatestStream() {
  CombineLatestStream.combine2(
    Stream.value('hello'),
    Stream.fromIterable(['mike', 'jon']),
    (a, b) => '$a $b',
  ).listen(print, onDone: () => print('done.'));
}

void studyCombineLatest2() async {
  PublishSubject sb1 = PublishSubject();
  PublishSubject sb2 = PublishSubject();

  Rx.combineLatest2(sb1.stream, sb2.stream, (a, b) => 'a:$a b:$b')
      .listen(print, onDone: () => print('done.'));

  print('sb1 onNext 1');
  sb1.add(1);
  print('sb2 onNext 10');
  sb2.add(10);
  print('sb1 onNext 2');
  sb1.add(2);
  print('sb1 onNext 3');
  sb1.add(3);
  print('sb2 onNext 20');
  sb2.add(20);
}

void studyCombineLatest3() {
  Rx.combineLatest4(
          Stream.value(1),
          Stream.value(10),
          Stream.value(100),
          Stream.fromIterable([3, 33, 333]),
          (int a, int b, int c, int d) => a + b + c + d)
      .listen(print, onDone: () => print('done.'));
}
