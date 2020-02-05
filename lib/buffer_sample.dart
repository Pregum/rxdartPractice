import 'package:rxdart/rxdart.dart';

Future studyBuffer() async {
  Observable<int>.periodic(const Duration(milliseconds: 100), (i) {
    // 100msecごとに値を生成する
    print('periodic: $i -- ${DateTime.now()}');
    return i;
  })
      // 150msecごとに購読したストリームをまとめる (型はObservable<List<int>>)
      .buffer(Observable<int>.periodic(const Duration(milliseconds: 150), (j) {
        print('buffer: ${j * 150}msec -- ${DateTime.now()}');
        // dummy data
        return j;
      }))
      // bufferでまとめたストリームを5要素取得する
      .take(5)
      // 購読する
      .listen((data) => print('listen: $data'), onDone: () => print('done. '));

  // 区切るために少し待つ
  await Future.delayed(const Duration(milliseconds: 1000));
  print('-----------------------------------------');

  Observable<int>.periodic(const Duration(milliseconds: 100), (i) {
    print('periodic: $i -- ${DateTime.now()}');
    return i;
  })
      // 購読したストリームを8要素取得する
      .take(8)
      // 300msecごとにまとめる
      .buffer(Observable.periodic(const Duration(milliseconds: 300)))
      // List<int>を購読する
      .listen((data) => print('listen: $data'), onDone: () => print('done.'));

}

// bufferTest
// void studyBufferTest() async {
//   Observable.fromIterable([1, 3, 4, 20, 80, 120, 12, 11, 150])
//       .bufferTest((s) => s > 100)
//       .listen(print);
// }

void studyBufferStream() async {
  // transform用に作成
  BufferStreamTransformer<int> transform =
      BufferStreamTransformer<int>((window) {
    return Stream<int>.periodic(const Duration(milliseconds: 150), (j) {
      print('buffer: ${j * 150}msec -- ${DateTime.now()}');
      // dummy data
      return j;
    });
  });

  // 100msecごとにストリームを生成する
  Stream<int>.periodic(const Duration(milliseconds: 100), (i) {
    print('periodic: $i -- ${DateTime.now()}');
    return i;
  })
      // 変換オペレータ(BufferStreamTransformer)で購読したストリームを
      .transform(transform)
      // bufferでまとめたストリームを5要素取得する
      .take(5)
      // List<int>を購読する
      .listen((data) => print('listen: $data'), onDone: () => print('done.'));

  // 区切る為に少し待つ
  await Future.delayed(const Duration(milliseconds: 1000));
  print('-----------------------------------------');

  Stream<int>.periodic(const Duration(milliseconds: 100), (i) {
    print('periodic: $i -- ${DateTime.now()}');
    return i;
  })
      // 購読したストリームを8要素取得する
      .take(8)
      // 300msecごとにまとめる
      .transform(BufferStreamTransformer<int>((window) {
    return Stream<int>.periodic(const Duration(milliseconds: 300));
  }))
      // List<int>を購読する
      .listen((data) => print('listen: $data'), onDone: () => print('done.'));
}
