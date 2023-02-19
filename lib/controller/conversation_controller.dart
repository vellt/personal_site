import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:personal_site/models/command.dart';
import 'package:personal_site/models/message.dart';
import 'dart:async';

class ConversationController extends GetxController {
  List<Message> messages = [];
  List<Command> commands = [];
  bool isEnglish = false;

  Future newAnswer({required String message}) async {
    await Future.delayed(const Duration(milliseconds: 150), () async {
      print("válasz folyamatban..");

      if (!_isTheCommandExist(message)) {
        await newAnswer(message: isEnglish ? "Not found" : "Nincs találat");
      } else {
        int index = _indexOfCommand(message, isEnglish: isEnglish);
        for (var answer
            in commands[index].answers[(isEnglish) ? "en" : "hu"]!) {
          bool condition =
              List.of(commands[index].answers[(isEnglish) ? "en" : "hu"]!)
                      .indexOf(answer) ==
                  0;
          await Future.delayed(Duration(milliseconds: (condition) ? 200 : 450),
              () {
            _addMessage(
                Message(id: messages.length + 1, isBot: true, message: answer));
          });
        }
        print("van.");
      }
    });
  }

  newCommand({required String message}) async {
    _addMessage(
        Message(id: messages.length + 1, isBot: false, message: message));
    switch (message) {
      case "Language to English":
        await _switchToEnglish(message);
        break;
      case "Válts angolra":
        await _switchToEnglish(message);
        break;
      case "Language to Hungarian":
        await _switchToHungarian(message);
        break;
      case "Válts magyarra":
        _switchToHungarian(message);
        break;
      default:
        newAnswer(message: message);
    }
  }

  Future _switchToEnglish(String message) async {
    isEnglish = true;
    newAnswer(message: message);
    await Future.delayed(Duration(milliseconds: 650), () {
      _addMessage(Message(
          id: 0,
          isBot: true,
          message: commands[_indexOfCommand("Köszönés", isEnglish: false)]
              .answers[(isEnglish) ? "en" : "hu"][0]));
    });
  }

  Future _switchToHungarian(String message) async {
    isEnglish = false;
    newAnswer(message: message);

    await Future.delayed(Duration(milliseconds: 650), () {
      _addMessage(Message(
          id: 0,
          isBot: true,
          message: commands[_indexOfCommand("Köszönés", isEnglish: false)]
              .answers[(isEnglish) ? "en" : "hu"][0]));
    });
  }

  _addMessage(Message message) {
    messages.add(message);
    update();
  }

  int _indexOfCommand(String command, {required bool isEnglish}) {
    return commands
        .map((e) => e.label[(isEnglish) ? "en" : "hu"].toString().toLowerCase())
        .toList()
        .indexOf(command.toLowerCase());
  }

  bool _isTheCommandExist(String command) {
    return commands
        .map((e) => e.label[(isEnglish) ? "en" : "hu"].toString().toLowerCase())
        .contains(command.toLowerCase());
  }

  @override
  void onInit() async {
    // TODO:
    super.onInit();
    final response = await http.get(Uri.parse(
        "https://gist.githubusercontent.com/vellt/70bef82cc7a33783c2d17037de5c564e/raw/d5c119f429743784ec0b3f11063b6adac2b41690/index.json"));
    commands = List<Command>.from(
        json.decode(response.body).map((item) => Command.fromJson(item)));

    _addMessage(Message(
        id: 0,
        isBot: true,
        message: commands[_indexOfCommand("Köszönés", isEnglish: false)]
            .answers[(isEnglish) ? "en" : "hu"][0]));
  }
}
