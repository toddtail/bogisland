import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/mark_controller.dart';

class MarkView extends GetView<MarkController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MarkView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'MarkView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
