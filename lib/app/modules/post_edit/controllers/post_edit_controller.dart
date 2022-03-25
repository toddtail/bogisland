import 'dart:typed_data';

import 'package:bog_island/app/common/function/notify.dart';
import 'package:bog_island/app/modules/content/controllers/content_controller.dart';
import 'package:bog_island/app/modules/forum/controllers/forum_controller.dart';
import 'package:bog_island/app/modules/global/controller/forum_list_controller.dart';
import 'package:bog_island/app/modules/post_edit/models/image_upload_model.dart';
import 'package:bog_island/app/modules/post_edit/models/post_argument_model.dart';
import 'package:bog_island/app/modules/post_edit/models/post_content_model.dart';
import 'package:bog_island/app/modules/post_edit/providers/image_upload_provider.dart';
import 'package:bog_island/app/modules/post_edit/providers/post_content_provider.dart';
import 'package:bog_island/app/modules/post_edit/widgets/cookie_choice_sheet.dart';
import 'package:bog_island/app/modules/setting/models/cookie_add_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

// emoji, input, image, post, cookie
class PostEditController extends GetxController {
  late TextEditingController editorController;
  final _postContentProvider = Get.find<PostContentProvider>();
  final storage = GetStorage();
  final imageUploadProvider = Get.find<ImageUploadProvider>();
  final forumListController = Get.find<ForumListController>();
  final _picker = ImagePicker();

  final isEmojiOff = true.obs;
  final isImageOff = true.obs;
  final onImageLoad = false.obs;
  bool _onPostConetent = false;
  final isNewPost = true.obs;
  final selectedImageXFileList = <XFile>[].obs;
  final selectedImageIdList = [].obs;
  final forumNameTarget = ''.obs;
  final cookieIndexSelectedForPost = 0.obs;

  int _forumIdTarget = 1;
  final topicIdTaget = 0.obs;

  final _tPostTextKey = 'post_text';
  final _tImageSelectedXFilePathListKey = 'image_selected_xfile_path_list';
  final _tImageSelectedIdListKey = 'image_selected_id_list';

  @override
  void onInit() {
    super.onInit();
    editorController = TextEditingController();
    cookieIndexSelectedForPost.value = readCookieSelectedIndexForPost();
    if (storage.hasData(_tPostTextKey)) {
      editorController.text = storage.read(_tPostTextKey);
    }
    if (storage.hasData(_tImageSelectedXFilePathListKey)) {
      final tempList = storage.read(_tImageSelectedXFilePathListKey);
      selectedImageXFileList.value =
          List.generate(tempList.length, (index) => XFile(tempList[index]));
    } else if (storage.hasData(_tImageSelectedIdListKey)) {
      selectedImageIdList.value = storage.read(_tImageSelectedIdListKey);
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
    storage.write(_tPostTextKey, editorController.text);
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
        storage.remove(_tPostTextKey);
        break;
      case 4:
        postContent();
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

  pickImageAndUpload() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    // TODO image load black
    if (image != null) {
      onImageLoad.value = true;
      final imageData = await image.readAsBytes();
      final imageContentType = 'image/${image.name.split('.')[1]}';
      final imageName = image.name;
      final isolateImageData = [imageData, imageContentType, imageName];

      // final value = await imageUploadProvider.postImageUpload(image);
      final String value = await compute(uploadImageIsolate, isolateImageData);

      if (value != 'error') {
        selectedImageIdList.add(value);
        selectedImageXFileList.add(image);
        List<String> tempXFilePathList;
        tempXFilePathList = List.generate(selectedImageXFileList.length,
            (index) => selectedImageXFileList[index].path);
        storage.write(_tImageSelectedXFilePathListKey, tempXFilePathList);
        storage.write(_tImageSelectedIdListKey, selectedImageIdList);
        onImageLoad.value = false;
        return true;
      } else {
        onImageLoad.value = false;
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
    storage.write(_tImageSelectedXFilePathListKey, selectedImageXFileList);
    storage.write(_tImageSelectedIdListKey, selectedImageIdList);
  }

  void showCookieChoiceSheet() {
    Get.bottomSheet(const CookieChoiceSheet());
  }

  List<CookieAddInfo> readCookieList() {
    List tempCookieList = storage.read('cookie');
    List<CookieAddInfo> cookieList = List.generate(tempCookieList.length,
        (index) => CookieAddInfo.fromJson(tempCookieList[index]));
    return cookieList;
  }

  int readCookieSelectedIndexForPost() {
    int selectedCookie = storage.read('cookie_selected_index');
    return selectedCookie;
  }

  void setCookieSelectedForPost(int index) {
    cookieIndexSelectedForPost.value = index;
    storage.write('cookie_selected_index', index);
  }

  String readMasterCookie() {
    return storage.read<String>('cookie_master')!;
  }

  String generateRequestCookie() {
    List<CookieAddInfo> cookieList = readCookieList();
    int selectedCookie = readCookieSelectedIndexForPost();
    final String cookieUse = cookieList[selectedCookie].cookie!;
    return 'bog_sel=$cookieUse';
  }

  void postContent() {
    if (!_onPostConetent) {
      Map<String, dynamic> data = {
        'comment': editorController.text,
        'webapp': 1,
        'cookie': readMasterCookie()
      };
      if (isNewPost.value) {
        data['forum'] = _forumIdTarget;
      } else {
        data['res'] = topicIdTaget.value;
      }
      if (selectedImageIdList.isNotEmpty) {
        if(selectedImageIdList.length == 1) {
          data['img[]'] =  selectedImageIdList[0];
        } else if(selectedImageIdList.length > 1) {
          data['img[]'] =  selectedImageIdList.value;
        }
      }
      _postContentProvider
          .postContent(generateRequestCookie(), data)
          .then((value) {
        print(
            'value.body is ${value.body.runtimeType} ${value.body is PostContent}');
        if (value.body is Map) {
          _onPostConetent = false;
        } else if (value.body is PostContent) {
          Get.back();
          showNormalSnackBar('发送成功', '已将你的信息发出');
          releaseContentAfterPostSucceed();
          refreshOutsideContentAfterPostSucceed();
          Get.back();
        }
      });
    }
    _onPostConetent = false;
  }

  void releaseContentAfterPostSucceed() {
    storage.remove(_tImageSelectedIdListKey);
    storage.remove(_tImageSelectedXFilePathListKey);
    storage.remove(_tPostTextKey);
  }

  void refreshOutsideContentAfterPostSucceed() {
    if (isNewPost.value) {
      Get.find<ForumController>().refreshTopic();
    } else {
      Get.find<ContentController>().refreshContent();
    }
  }
}

// top-level isolate function
Future<String> uploadImageIsolate(List data) async {
  final provider = Get.put<ImageUploadProvider>(ImageUploadProvider());
  final Response<dynamic> value = await provider.postImageUpload(data);
  if (value.body is ImageUpload) {
    return value.body.pic;
  } else {
    return 'error';
  }
}
