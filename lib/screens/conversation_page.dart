import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:personal_site/controller/conversation_controller.dart';
import 'package:personal_site/models/message.dart';
import 'package:sizer/sizer.dart';
import 'dart:html' as html;

class ConversationPage extends StatelessWidget {
  ConversationPage({Key? key}) : super(key: key);
  ConversationController conversationController =
      Get.put(ConversationController());

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
    late ScrollController autoScrollController = ScrollController();
    final FocusNode unitCodeCtrlFocusNode = FocusNode();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<ConversationController>(builder: (controller) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  right:
                      (SizerUtil.orientation == Orientation.portrait) ? 20 : 35,
                  left:
                      (SizerUtil.orientation == Orientation.portrait) ? 20 : 35,
                ),
                child: SizedBox(
                  height:
                      (SizerUtil.orientation == Orientation.portrait) ? 65 : 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "@vellt",
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Color.fromARGB(255, 207, 207, 207),
                                  fontWeight: FontWeight.w100),
                            ),
                            Row(
                              children: [
                                Text(
                                  "Portfolio site",
                                  style: TextStyle(
                                      fontSize: 19,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                SizedBox(
                                  height: 10.5,
                                  width: 8,
                                  child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: GestureDetector(
                                      child: JustTheTooltip(
                                        content: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("The site is available"),
                                        ),
                                        child: Container(
                                            height: 8,
                                            decoration: BoxDecoration(
                                                color: Colors.green,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)))),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                controller.switchLanguage();
                              },
                              icon: const Icon(
                                Icons.language,
                                color: Colors.black,
                                size: 22,
                              )),
                          IconButton(
                              onPressed: () {
                                controller.stillInProgress();
                              },
                              icon: const Icon(
                                Icons.dark_mode,
                                color: Colors.black,
                                size: 22,
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              SizedBox(
                height: 0.5,
                child: Divider(
                  color: Colors.black12,
                  height: 0.5,
                ),
              ),
              SizedBox(
                height: 1.5,
              ),
              Expanded(
                  child: Align(
                alignment: Alignment.topCenter,
                child: ListView.builder(
                  controller: autoScrollController,
                  reverse: true,
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(vertical: 20),
                  physics: BouncingScrollPhysics(),
                  itemCount: controller.messages.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                        right: (SizerUtil.orientation == Orientation.portrait)
                            ? 20
                            : 35,
                        left: (SizerUtil.orientation == Orientation.portrait)
                            ? 20
                            : 35,
                      ),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment:
                              (!List.from(controller.messages.reversed)[index]
                                      .isBot)
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                          children: [
                            if (List.from(controller.messages.reversed)[index]
                                    .isBot &&
                                SizerUtil.orientation != Orientation.portrait)
                              (List.from(controller.messages.reversed)[index]
                                          .isBehind ==
                                      IsBehind.user)
                                  ? Stack(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(top: 8),
                                          child: CircleAvatar(
                                            radius: 22,
                                            backgroundColor: Colors.white,
                                            backgroundImage: NetworkImage(
                                                "https://avatars.githubusercontent.com/u/61885011?size=120"), //"https://cdn.dribbble.com/userupload/3668818/file/original-82d33fec976d80ee37bdc10eb32c87c2.png?compress=1&resize=240x180&vertical=center"),
                                          ),
                                        ),
                                        Container(
                                          height: 51,
                                          width: 42,
                                          child: Align(
                                            alignment: Alignment.bottomRight,
                                            child: SizedBox(
                                              height: 10,
                                              width: 10,
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.green,
                                                      border: Border.all(
                                                          color: Colors.white),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20)))),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  : Container(
                                      child: CircleAvatar(
                                          radius: 22,
                                          backgroundColor: Colors.white),
                                    ),
                            if (SizerUtil.orientation != Orientation.portrait)
                              SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                    margin: EdgeInsets.symmetric(vertical: 8),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 25),
                                    constraints: BoxConstraints(
                                        maxWidth: (SizerUtil.orientation ==
                                                Orientation.portrait)
                                            ? 80.w
                                            : 60.w),
                                    decoration: BoxDecoration(
                                        color: (List.from(controller
                                                    .messages.reversed)[index]
                                                .isBot)
                                            ? Color(0xFFF4F4F4)
                                            : Colors.blue,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Builder(builder: (context) {
                                      return SelectableLinkify(
                                        onOpen: (link) {
                                          html.window.open(link.url, "_blank");
                                        },
                                        text: List.from(controller
                                                .messages.reversed)[index]
                                            .message,
                                        style: TextStyle(
                                            color: (List.from(controller
                                                        .messages
                                                        .reversed)[index]
                                                    .isBot)
                                                ? Colors.black
                                                : Colors.white),
                                      );
                                    })),
                                Builder(builder: (context) {
                                  DateTime dt = List.from(
                                          controller.messages.reversed)[index]
                                      .time as DateTime;
                                  String formattedDate =
                                      DateFormat('yyyy. MM. dd. (kk:mm)')
                                          .format(dt);
                                  return Text(
                                    formattedDate,
                                    style: TextStyle(
                                        fontSize: 10,
                                        color:
                                            Color.fromARGB(255, 207, 207, 207),
                                        fontWeight: FontWeight.w100),
                                  );
                                })
                              ],
                            )
                          ]),
                    );
                  },
                ),
              )),
              Padding(
                padding: EdgeInsets.only(
                  right:
                      (SizerUtil.orientation == Orientation.portrait) ? 20 : 35,
                  left:
                      (SizerUtil.orientation == Orientation.portrait) ? 20 : 35,
                ),
                child: SizedBox(
                  height: 3,
                  child: Divider(
                    color: Color.fromARGB(187, 242, 242, 242),
                    thickness: 1,
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: EdgeInsets.only(
                  right:
                      (SizerUtil.orientation == Orientation.portrait) ? 20 : 35,
                  left:
                      (SizerUtil.orientation == Orientation.portrait) ? 20 : 35,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Material(
                            color: Color.fromARGB(217, 249, 249, 249),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(8), // <-- Radius
                            ),
                            child: Container(
                              height: 65,
                              padding: const EdgeInsets.only(right: 15),
                              alignment: Alignment.center,
                              child: Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: TextField(
                                    textAlignVertical: TextAlignVertical
                                        .center, // ez még kellett h ténylgesen középre kerüljön a szöveg isDense: true,
                                    focusNode: unitCodeCtrlFocusNode,
                                    controller: textEditingController,
                                    onSubmitted: (value) {
                                      print('$value');
                                      controller.newCommand(message: value);
                                      textEditingController.clear();
                                      if (autoScrollController.hasClients)
                                        autoScrollController.jumpTo(0);
                                      FocusScope.of(context)
                                          .requestFocus(unitCodeCtrlFocusNode);
                                    },
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding: EdgeInsets.zero,
                                        hintText: "Write me..",
                                        hintStyle: TextStyle(
                                            color: Color.fromARGB(
                                                255, 144, 144, 144),
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal),
                                        border: InputBorder.none,
                                        prefixIcon: (SizerUtil.orientation ==
                                                Orientation.portrait)
                                            ? null
                                            : Icon(
                                                CupertinoIcons.text_bubble,
                                                size: 16,
                                              ))),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                      child: Center(
                        child: Text(
                          "©Copyright: ${DateTime.now().year}",
                          style: TextStyle(
                              color: Color(0xFFC2C2C2),
                              fontSize: 11,
                              fontWeight: FontWeight.w100),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
