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
        body: Column(
          children: [
            SizedBox(
              height: 95,
              child: Padding(
                padding: const EdgeInsets.only(right: 35, left: 35, bottom: 10),
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
                          const Text(
                            "@vellt",
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFFD4D4D4),
                                fontWeight: FontWeight.normal),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              const Text(
                                "Beni's Portfolio site",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xFF1A1A1A),
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(width: 14),
                              Container(
                                height: 8,
                                width: 8,
                                decoration: BoxDecoration(
                                    color: const Color(0xFF3BCF41),
                                    borderRadius: BorderRadius.circular(100)),
                              )
                            ],
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
            ),
            SizedBox(
              height: 2,
              child: Divider(
                color: Color(0xFFFAFAFA),
                thickness: 2,
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 20),
                physics: BouncingScrollPhysics(),
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 35),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: (index % 2 != 0)
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        //this will determine if the message should be displayed left or right
                        children: [
                          if ((index % 2 == 0))
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: CircleAvatar(
                                radius: 15,
                                backgroundImage: NetworkImage(
                                    "https://avatars.githubusercontent.com/u/61885011?v=4"),
                              ),
                            ),
                          SizedBox(width: 20),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 8),
                            padding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 35),
                            constraints: BoxConstraints(maxWidth: 60.w),
                            decoration: BoxDecoration(
                                color: (index % 2 == 0)
                                    ? Color(0xFFF4F4F4)
                                    : Colors.blue,
                                borderRadius: BorderRadius.circular(8)),
                            child: SelectableText(
                              "Lorem ipsum dolor sit amet, ",
                              style: TextStyle(
                                  color: (index % 2 == 0)
                                      ? Colors.black
                                      : Colors.white),
                            ),
                          )
                        ]),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: SizedBox(
                height: 2,
                child: Divider(
                  color: Color(0xFFFAFAFA),
                  thickness: 2,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 25),
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
                                  prefixIcon: IconButton(
                                      splashRadius: 18,
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.arrow_forward_ios_sharp,
                                        color: Color(0xFFBABABA),
                                        size: 16,
                                      )))),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: SizedBox(
                      height: 65,
                      width: 65,
                      child: Material(
                        color: Color(0xFFFAFAFA), // háttérszín beállítása
                        shape: const CircleBorder(),
                        child: SizedBox(
                          height: 50,
                          child: IconButton(
                              splashRadius: 31,
                              onPressed: () {},
                              icon: Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: const Icon(
                                  Icons.send,
                                  size: 26,
                                  color: Colors.blue,
                                ),
                              )),
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
    );
  }
}
