class Command {
  Map<String, String> label;
  Map<dynamic, dynamic> answers;

  Command({required this.label, required this.answers});

  factory Command.fromJson(Map<String, dynamic> json) {
    return Command(
      label: Map<String, String>.from(json['label']),
      answers: json['answers'].map((key, value) =>
          MapEntry<String, List<String>>(key, List<String>.from(value))),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['label'] = label;
    data['answers'] = answers.map(
      (key, value) => MapEntry(key, List<dynamic>.from(value)),
    );
    return data;
  }
}
