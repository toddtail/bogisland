import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostEditController extends GetxController {
  //TODO: Implement PostEditController
  late TextEditingController editorController;
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    editorController = TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
