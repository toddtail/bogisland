import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/content_controller.dart';

class ContentView extends GetView<ContentController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ContentView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'ContentView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
