import 'dart:convert';

import 'package:rxdart/rxdart.dart';

void mapFunction() {
  final subject = PublishSubject<String>();
  final Stream<String> mappedStream =
      subject.map((event) => event.toUpperCase());
  final Stream<double> mappedStream2 = subject
      .map((stringValue) => int.tryParse(stringValue) ?? 0)
      .map((intValue) => intValue * 100.0);
  final subStream = mappedStream.listen(print);
  final subStream2 = mappedStream2.listen(print);
  subject.add("SomeString");
  subject.add("SomeStfsdafg");
  subject.add("SomeStfasdsdring 321");
  subject.add("123");
  // subStream.cancel() - не нужно
  subject.close();
}

void main() {
  // mapFunction();
  apiExample();
}

class User {
  final String name;
  final int age;

  User(this.name, this.age);

  factory User.fromJson(String jsonString) {
    var jsonMap = json.decode(jsonString);

    return User(jsonMap['name'], jsonMap['age']);
  }

  @override
  String toString() {
    return "User(name=$name, age=$age)";
  }
}

void apiExample() {
  const jsonStrings = [
    '{"name": "Kostya", "age": 12}',
    '{"name": "Jully", "age": 42}',
    '{"name": "Kirill", "age": 6323}',
  ];

  final dataStreamFromApi = PublishSubject<String>();
  final userStream = dataStreamFromApi.map((event) => User.fromJson(event));
  userStream.listen(print);

  dataStreamFromApi.add(jsonStrings[0]);
  dataStreamFromApi.add(jsonStrings[1]);
  dataStreamFromApi.add(jsonStrings[2]);

  dataStreamFromApi.close();
}
