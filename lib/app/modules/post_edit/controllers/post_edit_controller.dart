import 'package:bog_island/app/modules/post_edit/providers/image_upload_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

// emoji, input, image, post
class PostEditController extends GetxController {
  late TextEditingController editorController;
  final storage = GetStorage();
  final imageUploadProvider = Get.find<ImageUploadProvider>();
  final ImagePicker _picker = ImagePicker();

  final isEmojiOff = true.obs;
  final selectedImageFileList = <XFile>[].obs;
  final imageCodeList = [].obs;

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
    switch (index) {
      case 1:
        isEmojiOff.value = !isEmojiOff.value;
        onEditorTextChanged();
        break;
      case 2:
        pickImage();
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
    editorController.selection = TextSelection.fromPosition(
        TextPosition(offset: editorController.text.length));
    onEditorTextChanged();
  }

  void pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImageFileList.add(image);
    }
    // jump provider, display image first
  }

  void getLostImage() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.files != null) {
      for (final XFile file in response.files!) {
        // _handleFile(file);
      }
    } else {
      // _handleError(response.exception);
    }
  }

  void removeSelectedImage(int index) {
    selectedImageFileList.removeAt(index);
  }
}
