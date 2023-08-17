class Command {
  String id;
  bool isEnabled;
  Map<String, String> label;
  Map<dynamic, dynamic> answers;

  Command(
      {required this.id,
      required this.isEnabled,
      required this.label,
      required this.answers});

  factory Command.fromJson(Map<String, dynamic> json) {
    return Command(
      id: json['id'],
      isEnabled: json['enabled'],
      label: Map<String, String>.from(json['label']),
      answers: json['answers'].map((key, value) =>
          MapEntry<String, List<String>>(key, List<String>.from(value))),
    );
  }
}
