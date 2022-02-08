import 'dart:convert';

import 'package:rxdart/rxdart.dart';

class Profile {
  final String name;
  Profile(this.name);
  factory Profile.fromJson(String jsonString) {
    final jsonObject = json.decode(jsonString);
    return Profile(jsonObject['name']);
  }
  @override
  String toString() {
    return ("Profile(name=$name)");
  }
}

class Media {
  final String url;
  Media(this.url);
  @override
  String toString() {
    return ("Media(url=$url)");
  }
}

class User {
  final Profile profile;
  final List<Media> medias;

  User(this.profile, this.medias);

  @override
  String toString() {
    return '${profile.toString()} - Count Media: ${medias.length}';
  }
}

Future<String> mockGetProfile() async {
  await Future.delayed(const Duration(seconds: 2));
  return '{"name": "Kostya"}';
}

Future<String> mockGetMedias() async {
  await Future.delayed(const Duration(seconds: 5));
  return '{"medias": [{"url": "someurl1"}, {"url": "someurl2"}, {"url": "someurl3"}]}';
}

void zipExample() {
  final profileStream = Stream.fromFuture(mockGetProfile())
      .map((event) => Profile.fromJson(event));

  final mediasStream = Stream.fromFuture(mockGetMedias()).map((event) {
    final jsonResponse = json.decode(event);
    final result = <Media>[];
    for (final mediaObj in jsonResponse['medias']) {
      result.add(Media(mediaObj['url']));
    }
    return result;
  });

  final userStream = profileStream.zipWith<List<Media>, User>(
      mediasStream, (p, m) => User(p, m));

  final listener = userStream.listen(print);
}

void main() {
  zipExample();
}
