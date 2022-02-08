import 'package:rxdart/rxdart.dart';

void margeExample() {
  final streamTwitterMessages = Stream<String>.periodic(
    const Duration(seconds: 1),
    (index) => "Message from twitter number$index",
  );
  final streamTelegramMessages = Stream<String>.periodic(
    const Duration(seconds: 2),
    (index) => "Message from telegram number$index",
  );
  final streamWhatsappMessages = Stream<String>.periodic(
    const Duration(seconds: 5),
    (index) => "Message from whatsapp number$index",
  );
  final mergeStream = streamTwitterMessages.mergeWith([
    streamTelegramMessages,
    streamWhatsappMessages,
  ]);

  final listener = mergeStream.listen(print);

  Future.delayed(const Duration(seconds: 30), () {
    listener.cancel();
  });
}

void main() {
  margeExample();
}
