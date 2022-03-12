import 'package:get/get.dart';

import 'package:bog_island/app/modules/forum/bindings/forum_binding.dart';
import 'package:bog_island/app/modules/forum/views/forum_view.dart';
import 'package:bog_island/app/modules/home/bindings/home_binding.dart';
import 'package:bog_island/app/modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.FORUM,
      page: () => ForumView(),
      binding: ForumBinding(),
    ),
  ];
}
