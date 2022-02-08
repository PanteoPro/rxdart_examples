import 'package:rxdart/rxdart.dart';

void debounce_example() async {
  final subject = PublishSubject<String>();

  subject
      .debounce((_) => TimerStream("Start", const Duration(milliseconds: 500)))
      .listen((event) {
    print(event);
  });

  subject.add("a");
  subject.add("ab");

  await Future.delayed(const Duration(milliseconds: 400));

  subject.add('abc');

  await Future.delayed(const Duration(milliseconds: 510));

  subject.add('abcd');

  subject.close();
}

void main() async {
  debounce_example();
}
