import 'package:rxdart/rxdart.dart';

/// rxdartのEmptyオペレータサンプル
void studyEmpty() {
  Stream.empty().listen((val) => print('liten: $val'),
      onDone: () => print('done.'), onError: () => print('error occurs.'));
}

/// Stream APIのEmptyオペレータサンプル
void studyEmptyStream() {
  Stream.empty().listen((val) => print('liten: $val'),
      onDone: () => print('done.'), onError: () => print('error occurs.'));
}

/// rxdartのNeverオペレータサンプル
void studyNever() {
  // neverオペレータで無限の期間を表現できます。
  // timeoutオペレータをchainすることで、時間切れを確実に起こすことができます。
  Rx.never()
      .timeout(Duration(seconds: 3),
          onTimeout: (err) => err.addError('time out error'))
      .listen((str) => print('listen: $str'),
          onError: (err) => print('error listen: $err'), cancelOnError: true);
}
// 実行結果
// error listen: time out error

/// Stream APIのNeverオペレータサンプル
void studyNeverStream() {
  NeverStream<String>()
      .timeout(Duration(seconds: 3),
          onTimeout: (err) => err.addError('time out error'))
      .listen((str) => print('listen: $str'),
          onError: (err) => print('error listen: $err'), cancelOnError: true);
}
// 実行結果
// error listen: time out error


/// rxdartのThrowオペレータサンプル
void studyThrow() {
  Stream.error('exception').listen(print,
      onDone: () => print('done.'),
      onError: (e) => print('error occurs: $e'),
      // cancelOnErrorにtrueを指定していない場合、onDoneも実行される
      cancelOnError: true);
}

/// Stream APIのThrowオペレータサンプル
void studyThrowStream() {
  Stream.error('exception').listen(print,
      onDone: () => print('done.'),
      onError: (e) => print('error occurs: $e'),
      // cancelOnErrorにtrueを指定していない場合、onDoneも実行される
      cancelOnError: true);
}
