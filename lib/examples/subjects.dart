import 'dart:async';
import 'package:rxdart/rxdart.dart';

Future<String> asyncFunction() async {
  return Future.delayed(const Duration(seconds: 2), () => "Async Result");
}

void fromFuture() {
  var fromFutureStream = Stream.fromFuture(asyncFunction());
  fromFutureStream.listen((event) {
    print("first Listener $event");
  });
}

void publishSubject() {
  final subject = PublishSubject<String>();
  subject.listen((value) {
    print(value);
  });

  subject.add("item1");

  subject.listen((value) {
    print(value.toUpperCase());
  });

  subject.add("item2");
  subject.add("item3");

  subject.close();
}

void behaviorSubject() {
  final subject = BehaviorSubject<String>();
  subject.listen((value) {
    print(value);
  });

  subject.add("item1");

  subject.listen((value) {
    print(value.toUpperCase());
  });

  subject.add("item2");
  subject.add("item3");

  subject.close();
}

void replaySubject() {
  final subject = ReplaySubject<String>();
  subject.add("item1");
  subject.add("item2");
  subject.add("item3");
  subject.add("item4");
  subject.add("item5");
  subject.add("item6");

  subject.listen((value) {
    print(value);
  });
  subject.listen((value) {
    print(value.toUpperCase());
  });

  subject.add("item7");

  subject.close();
}

void main() {
  replaySubject();
}
