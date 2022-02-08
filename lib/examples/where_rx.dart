import 'package:rxdart/rxdart.dart';

void where_example() {
  final subject = PublishSubject<int>();
  subject.where((event) => event.isEven).listen((event) {
    print('isEven $event');
  });
  subject.where((event) => event.isOdd).listen((event) {
    print('isOdd $event');
  });

  subject.add(1);
  subject.add(12);
  subject.add(2);
  subject.add(23);
  subject.add(3);

  subject.close();
}

void main() {
  where_example();
}
