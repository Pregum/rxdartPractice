import 'package:rxdart/rxdart.dart';

Future studyDebounce() async {
  // 500ms毎にカウントアップするストリームを生成する
  Stream.periodic(Duration(milliseconds: 500), (int i) => i)
      // 値発行から300ms後にイベントを発火する
      .debounce((event) {
        print('debounde: $event');
        return TimerStream(true, Duration(milliseconds: 300));
      })
      // 5要素取得する
      .take(5)
      .listen(print, onDone: () => print('on done.'));

  // 区切る為に少し待つ
  await Future.delayed(const Duration(milliseconds: 3000));
  print('--------------------------------------------------');

// 100ms毎にカウントアップするストリームを生成する
  Stream.periodic(Duration(milliseconds: 100), (int i) => i)
      // ５要素取得する
      .take(5)
      // この場合、300ms経つ前に次の値が先に来る為、フィルタされる
      .debounce((event) {
    print('debounde: $event');
    return TimerStream(true, Duration(milliseconds: 300));
  }).listen(print, onDone: () => print('on done.'));

  // 区切る為に少し待つ
  await Future.delayed(const Duration(milliseconds: 4000));
  print('--------------------------------------------------');

// 100ms毎にカウントアップするストリームを生成する
  Stream.periodic(Duration(milliseconds: 100), (int i) => i)
      // ５要素取得する
      .take(5)
      // 偶数のみ通す
      .debounce(
    (event) {
      print('debounde: $event, isEven: ${event.isEven}');
      if (event.isEven) {
        // trueでなくてもとりあえず値を返せば良い
        return Stream.value(true);
      } else {
        // 値は返さないといけないので、実質無限に遅延するStreamを返す
        return TimerStream(true, Duration(days: 99999));
      }
    },
  ).listen(print, onDone: () => print('on done.'));
}
