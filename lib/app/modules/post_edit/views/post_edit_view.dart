import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/post_edit_controller.dart';

class PostEditView extends GetView<PostEditController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PostEditView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'PostEditView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
