import 'dart:async';
import 'dart:math';

import 'package:rxdart/rxdart.dart';

int calculate() {
  return 6 * 7;
}

// concatは実行中のObservableが完了するまで、次のObservableが起動しないため
// 'do on listen.'は２つ目のObservableが完了してから表示されます。
void test_concat() {
  Observable.concat([
    Observable.just(0),
    Observable.timer(3, Duration(seconds: 3)),
    Observable.timer(2, Duration(seconds: 2))
        .doOnListen(() => print('do on listen from concat.')),
  ]).listen((i) => print('concat: $i'));
}

void test_coldListen() {
  var tes = Observable.concat([
    Observable.just(0),
    Observable.timer(3, Duration(seconds: 3)),
    Observable.timer(2, Duration(seconds: 2))
        .doOnListen(() => print('do on listen from concat.')),
  ]);

  tes.listen(print);
  tes.listen(print);
}

// concatEagerはconcatではできなかった、複数のObservableを同時に起動することができます。
// これにより'do on listen.'が実行後すぐ表示されます。
void test_concatEager() {
  Observable.concatEager([
    Observable.just(0),
    Observable.timer(3, Duration(seconds: 3)),
    Observable.timer(2, Duration(seconds: 2))
        .doOnListen(() => print('do on listen from concatEager.')),
  ]).listen(
    (i) => print('concatEager: $i'),
    onDone: () => print('done!'),
  );
}

void test_firstRx() async {
  // 値を発行するオブジェクト(Sink)を作成
  PublishSubject<String> subject = PublishSubject<String>();
  print('isBroadCast: ${subject.isBroadcast}');
  // 観察(購読)可能なオブジェクト(Stream)用変数を作成
  final Observable<String> observable = subject.stream;
  // 観察役(購読者)その1を登録(作成)
  final StreamSubscription<String> observer1 = observable.listen(
      // 観察(購読)しているオブジェクト(Stream)から値が流れてきた時に行う処理
      (str) => print('observable1 say: $str'),
      // エラーが流れてきた時に行う処理
      onError: (str) => print('error occurs!!!1!!!'),
      // Streamが閉じられた時に行う処理
      onDone: () => print('observer1 done.'));
  // 観察役(購読者)その2を登録(作成)
  final StreamSubscription<String> observer2 = observable
      // キャンセルした時に実行される処理
      .doOnCancel(() => print('on cancel 2.'))
      .listen((str) => print('observable2 say: $str'),
          onError: (str) => print('error occurs!!!2!!!'),
          onDone: () => print('observer2 done.'));

  // 値'step 1'を発行
  subject.add('step 1');
  // 値を購読する前にキャンセルされるのを防ぐ為、delayする
  await Future.delayed(Duration(milliseconds: 100));
  // 観察役(購読者)その2の購読をキャンセルさせたので、観察役(購読者)その2はこの後の値を購読しない
  await observer2.cancel();
  subject.add('step 2');
  // エラーを発行
  subject.addError('step error');
  subject.add('step 3');
  // Streamを閉じる
  await subject.close();
}

void test_broadCast() {
  // こっちだとsingle Subscription streamなので複数listenできないためExceptionが発生する
  StreamController<String> st = StreamController<String>();
  // broadcastファクトリ関数で作成したStreamはbroad castなので複数listen可能
  // StreamController<String> st = StreamController<String>.broadcast();
  // Subject系のStreamもbroad castなので複数listen可能
  // Subject<String> st = PublishSubject<String>();

  final Stream<String> observable = st.stream;
  print('isBroadCast: ${observable.isBroadcast}');
  var observer1 = observable.listen((val) => print('say 1 $val'));
  try {
    // ここでException発生
    var observer2 = observable.listen((val) => print('say 2 $val'));
  } catch (e) {
    print('error occurs');
  }
  st.sink.add('hello rx');
}

void test_errorClose() {
  // StreamController<int> st = StreamController<int>();
  // 値を発行するオブジェクト(Sink)を作成
  PublishSubject<int> st = PublishSubject<int>();

  final subject = st;
  final observable = st.stream;

  // エラー観察時、観察をキャンセルする観察役
  var cancelObserver = observable.listen((val) => print('cancelObserver listen: $val'),
      // エラー発生時に実行する処理
      onError: (error, stackTrace) => print('error occurs. cancel listen.'),
      // Streamが閉じられた時に実行する処理
      onDone: () => print('errorStopObserver done.'),
      // エラーが発生した時、観察をキャンセルするかどうかのフラグ(デフォルトはfalse)
      cancelOnError: true);
  // エラー観察時、観察を続ける観察役
  var continueObserver = observable.listen((val) => print('continueObserver listen: $val'),
      onError: (error, stackTrace) => print('error occurs. continue listen.'),
      onDone: () => print('continueObserver done.'));

  // 値5を発行
  subject.add(5);
  // エラーを発行
  // この時点で、cancelOnErrorがtrueの場合、観察(購読)をキャンセルする
  st.addError(3);
  // 値4を発行
  subject.add(4);
  // Streamを閉じる
  subject.close();
}

void testDoListen() {
  PublishSubject<int> st = PublishSubject<int>();

  final subject = st;
  final observable = st.stream;
  int count = 0;

  var time = Timer.periodic(Duration(milliseconds: 1000), (time) {
    if (count > 5) {
      print('timer cancel.');
      time.cancel();
      st.close();
      return;
    }
    st.add(count++);
  });

  var observer1 = observable.doOnListen(() => print('do on listen.')).listen(
      (i) => print('ob1 say: $i'),
      onDone: () => print('ob1 say: stream close.'));
}

void testAsync() async {
  final controller = StreamController<int>.broadcast();
  final subscription1 = controller.stream.listen(print);
  final subscription2 = controller.stream.listen(print);

  controller.sink.add(1);

  await Future.delayed(Duration(microseconds: 1));

  await subscription1.cancel();
  // await subscription2.cancel();
  // final subscription3 = controller.stream.listen(print);
  controller.sink.add(2);
  // await Future.delayed(Duration(seconds: 1));
  // await subscription3.cancel();
}


