class Command {
  String id;
  Map<String, String> label;
  Map<String, List<String>> answers;

  Command({required this.id, required this.label, required this.answers});

  factory Command.fromJson(Map<String, dynamic> json) {
    return Command(
      id: json['id'],
      label: Map<String, String>.from(json['label']),
      answers: Map<String, List<String>>.from(json['answers']).map(
        (key, value) => MapEntry(key, List<String>.from(value)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['label'] = label;
    data['answers'] = answers.map(
      (key, value) => MapEntry(key, List<dynamic>.from(value)),
    );
    return data;
  }
}
