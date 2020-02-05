import 'package:rxdart/rxdart.dart';

/// rxdartのCombineLatestオペレータサンプル
void studyCombineLatest() {
  Observable.combineLatest2(
    Observable.just('hello'),
    Observable.fromIterable(['mike', 'jon']),
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

  Observable.combineLatest2(sb1.stream, sb2.stream, (a, b) => 'a:$a b:$b')
      .listen(print, onDone: () => print('done.'));

  print('sb1 onNext 1');
  await sb1.add(1);
  print('sb2 onNext 10');
  await sb2.add(10);
  print('sb1 onNext 2');
  await sb1.add(2);
  print('sb1 onNext 3');
  await sb1.add(3);
  print('sb2 onNext 20');
  sb2.add(20);
}

void studyCombineLatest3() {
  Observable.combineLatest4(
      Observable.just(1),
      Observable.just(10),
      Observable.just(100),
      Observable.fromIterable([3, 33, 333]),
      (a, b, c, d) => a + b + c + d).listen(print, onDone: () => print('done.'));
}
