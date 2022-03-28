import 'package:bog_island/app/modules/home/bindings/home_binding.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';

initApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  HomeBinding().dependencies();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp
  ]);
  await GetStorage.init();
  await Future.delayed(const Duration(milliseconds: 400));
  return true;
}
