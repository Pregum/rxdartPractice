import 'package:rxdart/rxdart.dart';

// reusable=trueのRx.defer<T>
// rxdartのDeferオペレータ
void studyDeferWithReusable() async {
  var count = 0;
  // reusableにtrueを設定すると、ブロードキャストになるので複数購読可能
  var deferSubscription = Rx.defer(() {
    print('hello world: ${++count}');
    return Stream.value('defer push.');
  }, reusable: true);

  deferSubscription.listen((str) => print('listen1: $str'));
  // 複数Streamが発行されていることがわかるよう少し待機
  await Future.delayed(Duration(milliseconds: 10));
  // 二人目の購読者を登録してもエラーは発生しない
  deferSubscription.listen((str) => print('listen2: $str'));
}
// 実行結果
// hello world: 1
// listen1: defer push.
// hello world: 2
// listen2: defer push.

// reuasable=falseのRx.defer<T>
void studyDefer() async {
  var count = 0;
  // reusable引数をしていないため、reusableにはfalseが設定されている
  // その為シングルサブスクリプションなので、複数購読しようとするとエラーが発生する
  var deferSubscription = Rx.defer(() {
    print('hello world: ${++count}');
    return Stream.value('defer push.');
  });

  deferSubscription.listen((str) => print('listen1: $str'));
  // 複数Streamが発行されていることがわかるよう少し待機
  await Future.delayed(Duration(milliseconds: 10));
  // 下記の行をコメントアウトして実行するとエラーが発生する。
  // deferSubscription.listen((str) => print('listen2: $str'));
}
// 実行結果
// hello world: 1
// listen1: defer push.

// Stream APIのDeferオペレータ
void studyDeferStreamWithReusable() async {
  var count = 0;
  var deferSubscription = DeferStream<String>(() {
    print('hello world: ${++count}');
    return Stream<String>.value('defer push.');
  }, reusable: true);

  deferSubscription.listen((str) => print('listen1: $str'));
  // 複数Streamが発行されていることがわかるよう少し待機
  await Future.delayed(Duration(milliseconds: 10));
  // 二人目の購読者を登録してもエラーは発生しない
  deferSubscription.listen((str) => print('listen2: $str'));
}
// 実行結果
// hello world: 1
// listen1: defer push.
// hello world: 2
// listen2: defer push.

void studyDeferStream() async {
  var count = 0;
  // reusable引数をしていないため、reusableにはfalseが設定されている
  // その為シングルサブスクリプションなので、複数購読しようとするとエラーが発生する
  var deferSubscription = DeferStream<String>(() {
    print('hello world: ${++count}');
    return Stream<String>.value('defer push.');
  });

  deferSubscription.listen((str) => print('listen1: $str'));
  // 複数Streamが発行されていることがわかるよう少し待機
  await Future.delayed(Duration(milliseconds: 10));
  // 下記の行をコメントアウトするとエラーが発生する。
  // deferSubscription.listen((str) => print('listen2: $str'));
}
// 実行結果
// hello world: 1
// listen1: defer push.
