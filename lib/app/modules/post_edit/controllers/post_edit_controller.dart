import 'package:bog_island/app/modules/global/controller/forum_list_controller.dart';
import 'package:bog_island/app/modules/post_edit/models/image_upload_model.dart';
import 'package:bog_island/app/modules/post_edit/models/post_argument_model.dart';
import 'package:bog_island/app/modules/post_edit/providers/image_upload_provider.dart';
import 'package:bog_island/app/modules/post_edit/widgets/cookie_choice_sheet.dart';
import 'package:bog_island/app/modules/setting/controllers/setting_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

// emoji, input, image, post
class PostEditController extends GetxController {
  late TextEditingController editorController;
  final storage = GetStorage();
  final imageUploadProvider = Get.find<ImageUploadProvider>();
  final forumListController = Get.find<ForumListController>();
  final settingController = Get.find<SettingController>();
  final _picker = ImagePicker();

  final isEmojiOff = true.obs;
  final isImageOff = true.obs;
  final isOnImageLoad = false.obs;
  final isNewPost = true.obs;
  final selectedImageXFileList = <XFile>[].obs;
  final selectedImageIdList = [].obs;
  final forumNameTarget = ''.obs;

  int _forumIdTarget = 1;
  final topicIdTaget = 0.obs;

  final _postTextKey = 'post_text';
  final _imageSelectedXfileListKey = 'image_selected_xfile_list';
  final _imageSelectedIdListKey = 'image_selected_id_list';

  @override
  void onInit() {
    super.onInit();
    editorController = TextEditingController();

    if (storage.hasData(_postTextKey)) {
      editorController.text = storage.read(_postTextKey);
    }
    if (storage.hasData(_imageSelectedXfileListKey)) {
      selectedImageXFileList.value = storage.read(_imageSelectedXfileListKey);
    } else if (storage.hasData(_imageSelectedIdListKey)) {
      selectedImageIdList.value = storage.read(_imageSelectedIdListKey);
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

  void readArguments(dynamic arguments) {
    PostArgumentModel argumentModel = arguments;
    isNewPost.value = argumentModel.isNewPost!;
    _forumIdTarget = argumentModel.forumId!;
    topicIdTaget.value = argumentModel.topicId!;
    forumNameTarget.value = forumListController.liteForumMap[_forumIdTarget];
    if (!isNewPost.value && argumentModel.quoteId != null) {
      editorController.text =
          editorController.text + '>>Po.${argumentModel.quoteId}\n';
      onEditorTextChanged();
    }
  }

  void onEditorTextChanged() {
    storage.write(_postTextKey, editorController.text);
  }

  void onBarIconTap(int index) {
    switch (index) {
      case 0:
        showCookieChoiceSheet();
        break;
      case 1:
        isEmojiOff.value = !isEmojiOff.value;
        isImageOff.value = true;
        break;
      case 2:
        isImageOff.value = !isImageOff.value;
        isEmojiOff.value = true;
        break;
      case 3:
        editorController.clear();
        storage.remove(_postTextKey);
        break;
      case 4:
        break;
    }
  }

  onEditorTap() {
    isImageOff.value = true;
    isEmojiOff.value = true;
  }

  void onEmojiTap(String text) {
    editorController.text = editorController.text + text;
    editorController.selection = TextSelection.fromPosition(
        TextPosition(offset: editorController.text.length));
    onEditorTextChanged();
  }

  pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    // TODO image load black
    if (image != null) {
      isOnImageLoad.value = true;
      final imageData = await image.readAsBytes();
      final imageContentType = 'image/${image.name.split('.')[1]}';
      final imageName = image.name;
      final isolateImageData = [imageData, imageContentType, imageName];

      // final value = await imageUploadProvider.postImageUpload(image);
      final String value = await compute(uploadImageIsolate, isolateImageData);

      if (value != 'error') {
        selectedImageIdList.add(value);
        selectedImageXFileList.add(image);
        storage.write(_imageSelectedXfileListKey, selectedImageXFileList);
        storage.write(_imageSelectedIdListKey, selectedImageIdList);
        isOnImageLoad.value = false;
        return true;
      } else {
        isOnImageLoad.value = false;
      }
    }
    return false;
  }

  void getLostImage() async {
    //TODO in onInit
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
    selectedImageXFileList.removeAt(index);
    selectedImageIdList.removeAt(index);
    storage.write(_imageSelectedXfileListKey, selectedImageXFileList);
    storage.write(_imageSelectedIdListKey, selectedImageIdList);
  }

  void showCookieChoiceSheet() {
    Get.bottomSheet(const CookieChoiceSheet());
  }

  String generateRequestCookie() {
    final String master = GetStorage().read('cookie_master');
    final String cookieUse = settingController
        .cookieList[settingController.cookieSelectedIndex.value].cookie!;
    return 'bog_master=$master; bog_sel=$cookieUse';
  }
}

Future<String> uploadImageIsolate(List data) async {
  final provider = Get.put<ImageUploadProvider>(ImageUploadProvider());
  final Response<dynamic> value = await provider.postImageUpload(data);
  if (value.body is ImageUpload) {
    return value.body.pic;
  } else {
    return 'error';
  }
}
