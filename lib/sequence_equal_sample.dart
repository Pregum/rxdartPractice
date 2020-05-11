import 'package:rxdart/rxdart.dart';

/// rxdartのSequenceEqualオペレータサンプル
void studySequenceEqual() {
  Rx.sequenceEqual(Stream.fromIterable([1, 2, 3, 4, 5]),
      Stream.fromIterable([1, 2, 3, 4, 5])).listen(print);

  Rx.sequenceEqual(Stream.fromIterable([1, 2, 3, 4, 5]),
      Stream.fromIterable([1, 2, 3, 4])).listen(print);
}

/// Stream APIのSequenceEqualオペレータサンプル
void studySequenceEqualStream() {
  SequenceEqualStream(Stream.fromIterable([1, 2, 3, 4, 5]),
      Stream.fromIterable([1, 2, 3, 4, 5])).listen(print);

  SequenceEqualStream(Stream.fromIterable([1, 2, 3, 4, 5]),
      Stream.fromIterable([1, 2, 3, 4])).listen(print);
}
