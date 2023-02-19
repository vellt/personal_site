import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ConversationPage extends StatelessWidget {
  const ConversationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.only(
              right: (SizerUtil.orientation == Orientation.portrait) ? 20 : 35,
              left: (SizerUtil.orientation == Orientation.portrait) ? 20 : 35,
              bottom:
                  (SizerUtil.orientation == Orientation.portrait) ? 20 : 35),
          child: Column(
            children: [
              SizedBox(
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
                          color: Color(0xFF1A1A1A),
                          size: 22,
                        )),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  physics: BouncingScrollPhysics(),
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: (index % 2 != 0)
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        //this will determine if the message should be displayed left or right
                        children: [
                          if ((index % 2 == 0) &&
                              SizerUtil.orientation != Orientation.portrait)
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.white,
                                backgroundImage: NetworkImage(
                                    "https://cdn.dribbble.com/userupload/3668818/file/original-82d33fec976d80ee37bdc10eb32c87c2.png?compress=1&resize=240x180&vertical=center"),
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
                                color: (index % 2 == 0)
                                    ? Color(0xFFF4F4F4)
                                    : Colors.blue,
                                borderRadius: BorderRadius.circular(8)),
                            child: SelectableText(
                              "Lorem! 👋 Ipsum dolor sit amet! 🎉🎉",
                              style: TextStyle(
                                  color: (index % 2 == 0)
                                      ? Colors.black
                                      : Colors.white),
                            ),
                          )
                        ]);
                  },
                ),
              ),
              SizedBox(
                height: 2,
                child: Divider(
                  color: Color(0xFFFAFAFA),
                  thickness: 2,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: (SizerUtil.orientation == Orientation.portrait)
                        ? 15
                        : 25),
                child: Row(
                  children: [
                    Flexible(
                      child: Material(
                        color: Color(0xFFFAFAFA),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8), // <-- Radius
                        ),
                        child: Container(
                          height: 65,
                          padding: const EdgeInsets.only(right: 15),
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: TextField(
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal),
                                textAlignVertical: TextAlignVertical.center,
                                decoration: InputDecoration(
                                    hintText: "Write me..",
                                    hintStyle: TextStyle(
                                        color: Color(0xFFA4A4A4),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w200),
                                    border: InputBorder.none,
                                    prefixIcon: (SizerUtil.orientation ==
                                            Orientation.portrait)
                                        ? null
                                        : Icon(
                                            Icons.message,
                                            color: Color(0xFFBABABA),
                                            size: 16,
                                          ))),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
