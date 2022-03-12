import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/forum_controller.dart';

class ForumView extends GetView<ForumController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ForumView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'ForumView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
