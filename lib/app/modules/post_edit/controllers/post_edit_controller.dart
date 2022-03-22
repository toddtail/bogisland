import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PostEditController extends GetxController {
  late TextEditingController editorController;
  final storage = GetStorage();
  final isEmojiOff = true.obs;

  @override
  void onInit() {
    super.onInit();
    editorController = TextEditingController();
    if (storage.hasData('post_text')) {
      editorController.text = storage.read('post_text');
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    print('PostEditController Onclose');
  }

  void onEditorTextChanged() {
    storage.write('post_text', editorController.text);
  }

  void onBarIconTap(int index) {
    switch(index) {
      case 1:
        isEmojiOff.value = !isEmojiOff.value;
        onEditorTextChanged();
        break;
      case 2:
        break;
      case 3:
        editorController.clear();
        break;
      case 4:
        break;
    }
  }

  void onEmojiTap(String text) {
    editorController.text = editorController.text + text;
    editorController.selection = TextSelection.fromPosition(TextPosition(offset: editorController.text.length));
    onEditorTextChanged();
  }
}
