import 'package:bog_island/app/data/emoji.dart';
import 'package:bog_island/app/data/tailwind_colors.dart';
import 'package:bog_island/app/modules/post_edit/controllers/post_edit_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

class EmojiSheet extends GetWidget<PostEditController> {
  const EmojiSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Column(
        children: [
          TabBar(indicatorColor: colorRed400, tabs: [
            Tab(
              icon: const Text('ᕕ[ ᐛ ]ᕗ').textColor(colorNeutral600),
            ),
            Tab(
              icon: const Text('(￣3￣)').textColor(colorNeutral600),
            ),
            Tab(
              icon: const Text('🤡').textColor(colorNeutral600),
            ),
            Tab(
              icon: const Text('Roll').textColor(colorNeutral600),
            ),
          ]),
          TabBarView(
            children: [
              singleEmojiPanel('kaomoji'),
              singleEmojiPanel('bmoji'),
              singleEmojiPanel('emoji'),
              singleEmojiPanel('speical'),
            ],
          ).width(1.sw).height(0.25.sh),
        ],
      ).backgroundColor(colorAmber100),
    );
  }

  Widget singleEmojiPanel(String key) {
    return SingleChildScrollView(
      child: GridView.count(
        crossAxisCount: 4,
        childAspectRatio: 0.25.sw / 0.075.sh,
        children: List.generate(
            emojiMap[key]!.length, (index) => emojiText(emojiMap[key]![index])),
      ).width(1.sw).height(0.25.sh),
    );
  }

  Widget emojiText(String text) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
          onTap: () {
            controller.onEmojiTap(text);
          },
          child: Center(
            child: Text(text).fontSize(12.sp).textColor(colorNeutral600),
          )),
    );
  }
}

