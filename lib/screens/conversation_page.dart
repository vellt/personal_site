import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:link_preview_generator/link_preview_generator.dart';
import 'package:personal_site/controller/conversation_controller.dart';
import 'package:sizer/sizer.dart';
import 'dart:html' as html;
import 'package:flutter_link_previewer/flutter_link_previewer.dart';

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
                  height: 95,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Beni's",
                              style: TextStyle(
                                  fontSize: 19,
                                  color: Color(0xFF1A1A1A),
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Portfolio site",
                              style: TextStyle(
                                  fontSize: 19,
                                  color: Color(0xFF5E5E5E),
                                  fontWeight: FontWeight.w100),
                            )
                          ],
                        ),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.dark_mode,
                            color: Colors.black,
                            size: 22,
                          )),
                    ],
                  ),
                ),
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
                          //this will determine if the message should be displayed left or right
                          children: [
                            if (List.from(controller.messages.reversed)[index]
                                    .isBot &&
                                SizerUtil.orientation != Orientation.portrait)
                              Padding(
                                padding: EdgeInsets.only(top: 8),
                                child: CircleAvatar(
                                  radius: 22,
                                  backgroundColor: Colors.white,

                                  backgroundImage: NetworkImage(
                                      "https://avatars.githubusercontent.com/u/61885011?v=4"), //"https://cdn.dribbble.com/userupload/3668818/file/original-82d33fec976d80ee37bdc10eb32c87c2.png?compress=1&resize=240x180&vertical=center"),
                                ),
                              ),
                            if (SizerUtil.orientation != Orientation.portrait)
                              SizedBox(width: 16),
                            Container(
                                margin: EdgeInsets.symmetric(vertical: 8),
                                padding: EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 25),
                                constraints: BoxConstraints(maxWidth: 60.w),
                                decoration: BoxDecoration(
                                    color: (List.from(controller
                                                .messages.reversed)[index]
                                            .isBot)
                                        ? Color(0xFFF4F4F4)
                                        : Colors.blue,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Builder(builder: (context) {
                                  return Linkify(
                                    onOpen: (link) {
                                      html.window.open(link.url, "_blank");
                                    },
                                    text: List.from(
                                            controller.messages.reversed)[index]
                                        .message,
                                    style: TextStyle(
                                        color: (List.from(controller
                                                    .messages.reversed)[index]
                                                .isBot)
                                            ? Colors.black
                                            : Colors.white),
                                  );
                                }))
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
                  height: 2,
                  child: Divider(
                    color: Color(0xFFFAFAFA),
                    thickness: 2,
                  ),
                ),
              ),
              SizedBox(
                height: 12,
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
                            color: Color(0xFFFAFAFA),
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
                                        fontWeight: FontWeight.normal),
                                    textAlignVertical: TextAlignVertical.center,
                                    decoration: InputDecoration(
                                        hintText: "Write me..",
                                        hintStyle: TextStyle(
                                            color: Color(0xFFA4A4A4),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w200),
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
