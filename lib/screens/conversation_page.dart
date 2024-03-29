import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:personal_site/controllers/conversation_controller.dart';
import 'package:personal_site/controllers/theme_controller.dart';
import 'package:personal_site/models/message.dart';
import 'package:personal_site/storage/theme_storage.dart';
import 'package:sizer/sizer.dart';
import 'dart:html' as html;
import '../global.dart';

class ConversationPage extends StatelessWidget {
  const ConversationPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
    late ScrollController autoScrollController = ScrollController();
    final FocusNode unitCodeCtrlFocusNode = FocusNode();
    return SafeArea(
      child: GetBuilder<ThemeController>(
          init: theme,
          builder: (theme) {
            return Scaffold(
              backgroundColor: theme.mainBackground,
              body: GetBuilder<ConversationController>(
                  init: conversationController,
                  builder: (controller) {
                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            right:
                                (SizerUtil.orientation == Orientation.portrait)
                                    ? 20
                                    : 35,
                            left:
                                (SizerUtil.orientation == Orientation.portrait)
                                    ? 20
                                    : 35,
                          ),
                          child: SizedBox(
                            height:
                                (SizerUtil.orientation == Orientation.portrait)
                                    ? 65
                                    : 80,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "@vellt",
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: theme.subTitleColor,
                                            fontWeight: FontWeight.w100),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Portfolio site",
                                            style: TextStyle(
                                                fontSize: 19,
                                                color: theme.mainTitleColor,
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
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                        "The site is available"),
                                                  ),
                                                  child: Container(
                                                    height: 8,
                                                    decoration: BoxDecoration(
                                                      color: theme
                                                          .onlineSignalColor,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(20),
                                                      ),
                                                    ),
                                                  ),
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
                                        icon: Icon(
                                          Icons.language,
                                          color: theme.iconColor,
                                          size: 22,
                                        )),
                                    IconButton(
                                        onPressed: () {
                                          controller.stillInProgress(
                                              theme.switchTheme);
                                        },
                                        icon: Icon(
                                          (theme.currentTheme == Themes.light)
                                              ? Icons.dark_mode
                                              : Icons.light_mode,
                                          color: theme.iconColor,
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
                            color: theme.upperDividerColor,
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
                                  right: (SizerUtil.orientation ==
                                          Orientation.portrait)
                                      ? 20
                                      : 35,
                                  left: (SizerUtil.orientation ==
                                          Orientation.portrait)
                                      ? 20
                                      : 35,
                                ),
                                child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: (!List.from(controller
                                                .messages.reversed)[index]
                                            .isBot)
                                        ? MainAxisAlignment.end
                                        : MainAxisAlignment.start,
                                    children: [
                                      if (List.from(controller
                                                  .messages.reversed)[index]
                                              .isBot &&
                                          SizerUtil.orientation !=
                                              Orientation.portrait)
                                        (List.from(controller.messages
                                                        .reversed)[index]
                                                    .isBehind ==
                                                IsBehind.user)
                                            ? Stack(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.only(top: 8),
                                                    child: CircleAvatar(
                                                      radius: 22,
                                                      backgroundColor:
                                                          theme.mainBackground,
                                                      backgroundImage: NetworkImage(
                                                          "https://avatars.githubusercontent.com/u/61885011?size=120"), //"https://cdn.dribbble.com/userupload/3668818/file/original-82d33fec976d80ee37bdc10eb32c87c2.png?compress=1&resize=240x180&vertical=center"),
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 51,
                                                    width: 42,
                                                    child: Align(
                                                      alignment:
                                                          Alignment.bottomRight,
                                                      child: SizedBox(
                                                        height: 10,
                                                        width: 10,
                                                        child: Container(
                                                            decoration: BoxDecoration(
                                                                color: theme
                                                                    .onlineSignalColor,
                                                                border: Border.all(
                                                                    color: theme
                                                                        .mainBackground),
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            20)))),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )
                                            : Container(
                                                child: CircleAvatar(
                                                    radius: 22,
                                                    backgroundColor:
                                                        Colors.transparent),
                                              ),
                                      if (SizerUtil.orientation !=
                                          Orientation.portrait)
                                        SizedBox(width: 16),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 8),
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 20, horizontal: 25),
                                              constraints: BoxConstraints(
                                                  maxWidth: (SizerUtil
                                                              .orientation ==
                                                          Orientation.portrait)
                                                      ? 80.w
                                                      : 60.w),
                                              decoration: BoxDecoration(
                                                  color: (List.from(controller
                                                              .messages
                                                              .reversed)[index]
                                                          .isBot)
                                                      ? theme
                                                          .botMessageBoxBackground
                                                      : theme
                                                          .clientMessageBoxBackground,
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              child: Builder(builder: (context) {
                                                return SelectableLinkify(
                                                  onOpen: (link) {
                                                    html.window.open(
                                                        link.url, "_blank");
                                                  },
                                                  text: List.from(controller
                                                          .messages
                                                          .reversed)[index]
                                                      .message,
                                                  style: TextStyle(
                                                      color: (List.from(controller
                                                                      .messages
                                                                      .reversed)[
                                                                  index]
                                                              .isBot)
                                                          ? theme
                                                              .botMessageBoxFontColor
                                                          : theme
                                                              .clientMessageBoxFontColor),
                                                );
                                              })),
                                          Builder(builder: (context) {
                                            DateTime dt = List.from(controller
                                                    .messages.reversed)[index]
                                                .time as DateTime;
                                            String formattedDate = DateFormat(
                                                    'yyyy. MM. dd. (kk:mm)')
                                                .format(dt);
                                            return Text(
                                              formattedDate,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: theme.subTitleColor,
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
                                (SizerUtil.orientation == Orientation.portrait)
                                    ? 20
                                    : 35,
                            left:
                                (SizerUtil.orientation == Orientation.portrait)
                                    ? 20
                                    : 35,
                          ),
                          child: SizedBox(
                            height: 3,
                            child: Divider(
                              color: theme.bottomDividerColor,
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
                                (SizerUtil.orientation == Orientation.portrait)
                                    ? 20
                                    : 35,
                            left:
                                (SizerUtil.orientation == Orientation.portrait)
                                    ? 20
                                    : 35,
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Flexible(
                                    child: Material(
                                      color: theme.textInputFieldBackground,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Container(
                                        height: 65,
                                        padding:
                                            const EdgeInsets.only(right: 15),
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
                                                controller.newCommand(
                                                    message: value);
                                                textEditingController.clear();
                                                if (autoScrollController
                                                    .hasClients)
                                                  autoScrollController
                                                      .jumpTo(0);
                                                FocusScope.of(context)
                                                    .requestFocus(
                                                        unitCodeCtrlFocusNode);
                                              },
                                              style: TextStyle(
                                                color: theme.mainTitleColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal,
                                              ),
                                              decoration: InputDecoration(
                                                  isDense: true,
                                                  contentPadding:
                                                      EdgeInsets.zero,
                                                  hintText: "Write me..",
                                                  hintStyle: TextStyle(
                                                      color: theme
                                                          .textInputFieldHintColor,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                  border: InputBorder.none,
                                                  prefixIcon: (SizerUtil
                                                              .orientation ==
                                                          Orientation.portrait)
                                                      ? null
                                                      : Icon(
                                                          CupertinoIcons
                                                              .text_bubble,
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
                                        color: theme.subTitleColor,
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
            );
          }),
    );
  }
}
