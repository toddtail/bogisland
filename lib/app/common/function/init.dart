import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

initApp() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(const Duration(milliseconds: 100));
  await GetStorage.init();
  return true;
}