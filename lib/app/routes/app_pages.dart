import 'package:bog_island/app/modules/content/views/conetnt_view_new.dart';
import 'package:get/get.dart';

import '../modules/content/bindings/content_binding.dart';
import '../modules/content/views/content_view.dart';
import '../modules/forum/bindings/forum_binding.dart';
import '../modules/forum/views/forum_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/image_viewer/bindings/image_viewer_binding.dart';
import '../modules/image_viewer/views/image_viewer_view.dart';
import '../modules/mark/bindings/mark_binding.dart';
import '../modules/mark/views/mark_view.dart';
import '../modules/post_edit/bindings/post_edit_binding.dart';
import '../modules/post_edit/views/post_edit_view.dart';
import '../modules/setting/bindings/setting_binding.dart';
import '../modules/setting/views/setting_view.dart';

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
    GetPage(
      name: _Paths.POST_EDIT,
      page: () => PostEditView(),
      binding: PostEditBinding(),
    ),
    GetPage(
      name: _Paths.CONTENT,
      page: () => ContentViewNew(),
      binding: ContentBinding(),
    ),
    GetPage(
      name: _Paths.IMAGE_VIEWER,
      page: () => ImageViewerView(),
      binding: ImageViewerBinding(),
    ),
    GetPage(
      name: _Paths.MARK,
      page: () => MarkView(),
      binding: MarkBinding(),
    ),
    GetPage(
      name: _Paths.SETTING,
      page: () => SettingView(),
      binding: SettingBinding(),
    ),
  ];
}
