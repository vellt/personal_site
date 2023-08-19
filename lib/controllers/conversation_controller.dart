import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:personal_site/models/command.dart';
import 'package:personal_site/models/message.dart';
import 'dart:async';
import 'package:string_similarity/string_similarity.dart';
import 'package:diacritic/diacritic.dart';

class ConversationController extends GetxController {
  List<Message> messages = [];
  List<Command> commands = [];
  bool isEnglish = false;

  Future newAnswer({required String message, required bool isEnabled}) async {
    await Future.delayed(const Duration(milliseconds: 150), () async {
      if (!_isTheCommandExist(message, isEnabled)) {
        BestMatch matches = (isEnglish)
            ? message.toLowerCase().trim().bestMatch(commands
                .where((element) => element.isEnabled == isEnabled)
                .map((e) => (e.label["en"].toString()).toLowerCase().trim())
                .toList())
            : removeDiacritics(message.toLowerCase().trim()).bestMatch(commands
                .where((element) => element.isEnabled == isEnabled)
                .map((e) => (e.id.toString()).toLowerCase().trim())
                .toList());
        // van 80%-ban egyező találat
        if (matches.bestMatch.rating != null &&
            matches.bestMatch.rating! >= 0.75) {
          int index = matches.bestMatchIndex;

          await Future.delayed(Duration(milliseconds: 100), () {
            _addMessage(Message(
                id: messages.length + 1,
                isBot: true,
                isBehind: messages.length - 1 < 0
                    ? IsBehind.user
                    : (messages[messages.length - 1].isBot
                        ? IsBehind.bot
                        : IsBehind.user),
                time: DateTime.now(),
                message: (isEnglish)
                    ? "Is that what you meant? 📌 ${commands.where((element) => element.isEnabled == isEnabled).map((e) => e.label[(isEnglish) ? "en" : "hu"]).toList()[matches.bestMatchIndex]}"
                    : "Erre gondolt? 📌 ${commands.where((element) => element.isEnabled == isEnabled).map((e) => e.label[(isEnglish) ? "en" : "hu"]).toList()[matches.bestMatchIndex]}"));
          });
          print("van egy majdnem talalat: ${message}");
          for (var answer in commands
              .where((element) => element.isEnabled == isEnabled)
              .toList()[index]
              .answers[(isEnglish) ? "en" : "hu"]!) {
            bool condition = List.of(commands
                        .where((element) => element.isEnabled == isEnabled)
                        .toList()[index]
                        .answers[(isEnglish) ? "en" : "hu"]!)
                    .indexOf(answer) ==
                0;
            await Future.delayed(
                Duration(milliseconds: (condition) ? 200 : 450), () {
              _addMessage(Message(
                  id: messages.length + 1,
                  isBot: true,
                  time: DateTime.now(),
                  isBehind: messages.length - 1 < 0
                      ? IsBehind.user
                      : (messages[messages.length - 1].isBot
                          ? IsBehind.bot
                          : IsBehind.user),
                  message: answer));
            });
          }
        } else {
          //biztios nem létezik
          print("nincs talalat: ${message}");
          await newAnswer(
              message: isEnglish ? "Not found" : "Nincs találat",
              isEnabled: false);
          await newAnswer(
              message: isEnglish ? "Command list" : "Parancs lista",
              isEnabled: true);
        }
      } else {
        // van pontosan egyező találat
        print("van egy pontos talalat: ${message}");
        int index = _indexOfCommand(message,
            isEnglish: isEnglish, isEnabled: isEnabled);
        for (var answer in commands
            .where((element) => element.isEnabled == isEnabled)
            .toList()[index]
            .answers[(isEnglish) ? "en" : "hu"]!) {
          bool condition = List.of(commands
                      .where((element) => element.isEnabled == isEnabled)
                      .toList()[index]
                      .answers[(isEnglish) ? "en" : "hu"]!)
                  .indexOf(answer) ==
              0;
          await Future.delayed(Duration(milliseconds: (condition) ? 200 : 450),
              () {
            _addMessage(Message(
                id: messages.length + 1,
                isBot: true,
                isBehind: messages.length - 1 < 0
                    ? IsBehind.user
                    : (messages[messages.length - 1].isBot
                        ? IsBehind.bot
                        : IsBehind.user),
                time: DateTime.now(),
                message: answer));
          });
        }
      }
    });
  }

  newCommand({required String message}) async {
    if (message.trim() != "") {
      _addMessage(Message(
          id: messages.length + 1,
          isBot: false,
          isBehind: messages.length - 1 < 0
              ? IsBehind.user
              : (messages[messages.length - 1].isBot
                  ? IsBehind.bot
                  : IsBehind.user),
          time: DateTime.now(),
          message: message));
      newAnswer(message: message, isEnabled: true);
    }
  }

  Future stillInProgress(Function() switchTheme) async {
    switchTheme();
  }

  Future switchLanguage() async {
    isEnglish = !isEnglish;
    if (isEnglish) {
      newAnswer(message: "en", isEnabled: false);
      await Future.delayed(Duration(milliseconds: 650), () {
        _addMessage(Message(
            id: messages.length + 1,
            isBot: true,
            isBehind: messages.length - 1 < 0
                ? IsBehind.user
                : (messages[messages.length - 1].isBot
                    ? IsBehind.bot
                    : IsBehind.user),
            time: DateTime.now(),
            message: commands[_indexOfCommand("Köszönés",
                    isEnglish: false, isEnabled: true)]
                .answers[(isEnglish) ? "en" : "hu"][0]));
      });
    } else {
      newAnswer(message: "hu", isEnabled: false);
      await Future.delayed(Duration(milliseconds: 650), () {
        _addMessage(Message(
            id: messages.length + 1,
            isBot: true,
            isBehind: messages.length - 1 < 0
                ? IsBehind.user
                : (messages[messages.length - 1].isBot
                    ? IsBehind.bot
                    : IsBehind.user),
            time: DateTime.now(),
            message: commands[_indexOfCommand("Köszönés",
                    isEnglish: false, isEnabled: true)]
                .answers[(isEnglish) ? "en" : "hu"][0]));
      });
    }
  }

  _addMessage(Message message) {
    messages.add(message);
    update();
  }

  int _indexOfCommand(String command,
      {required bool isEnglish, required bool isEnabled}) {
    return commands
        .where((element) => element.isEnabled == isEnabled)
        .map((e) => e.label[(isEnglish) ? "en" : "hu"].toString().toLowerCase())
        .toList()
        .indexOf(command.toLowerCase().trim());
  }

  bool _isTheCommandExist(String command, isEnabled) {
    print(">>>>>${command} ${isEnabled}");
    return commands
        .where((element) => element.isEnabled == isEnabled)
        .map((e) => e.label[(isEnglish) ? "en" : "hu"].toString().toLowerCase())
        .contains(command.toLowerCase());
  }

  @override
  void onInit() async {
    // TODO:
    super.onInit();
    final response = await http.get(Uri.parse(
        "https://gist.githubusercontent.com/vellt/70bef82cc7a33783c2d17037de5c564e/raw/51ceb9f6cd1f4ed3e221e5b042e4043538684d59/index.json"));
    commands = List<Command>.from(
        json.decode(response.body).map((item) => Command.fromJson(item)));

    print(_indexOfCommand("Köszönés", isEnglish: false, isEnabled: true));
    _addMessage(Message(
        id: 0,
        isBot: true,
        isBehind: messages.length - 1 < 0
            ? IsBehind.user
            : (messages[messages.length - 1].isBot
                ? IsBehind.bot
                : IsBehind.user),
        time: DateTime.now(),
        message: commands[
                _indexOfCommand("Köszönés", isEnglish: false, isEnabled: true)]
            .answers[(isEnglish) ? "en" : "hu"][0]));
  }
}
