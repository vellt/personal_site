class Message {
  int id;
  bool isBot;
  IsBehind isBehind;
  String message;
  Message(
      {required this.id,
      required this.isBot,
      required this.isBehind,
      required this.message});
}

enum IsBehind { User, Bot }
