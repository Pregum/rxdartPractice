import 'package:rxdart/rxdart.dart';

Future studyDebounce() async {
  Stream.periodic(Duration(milliseconds: 100), (int i) => i)
      .take(20)
      .debounce((_) => TimerStream(true, Duration(milliseconds: 300)))
      .listen(print, onDone: () => print('on done.'));

  // 区切る為に少し待つ
  // await Future.delayed(const Duration(milliseconds: 2000));
  // print('--------------------------------------------------');

  // Stream.periodic(Duration(milliseconds: 500), (int i) => i)
  //     .take(5)
  //     .listen(print, onDone: () => print('on done.'));
}
