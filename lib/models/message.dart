class Message {
  int id;
  bool isBot;
  IsBehind isBehind;
  String message;
  DateTime time;
  Message({
    required this.id,
    required this.isBot,
    required this.isBehind,
    required this.message,
    required this.time,
  });
}

enum IsBehind { user, bot }
