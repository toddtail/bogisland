import 'package:bog_island/app/common/function/notify.dart';
import 'package:bog_island/app/common/function/topic_to_threads_transfer.dart';
import 'package:bog_island/app/modules/content/models/content_argument_model.dart';
import 'package:bog_island/app/modules/content/models/threads_model.dart';
import 'package:bog_island/app/modules/content/providers/threads_provider.dart';
import 'package:bog_island/app/modules/forum/models/topics_in_forum_model.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ContentController extends GetxController {
  final threadsProvider = Get.find<ThreadsProvider>();
  final contentList = <ThreadsReply>[].obs;
  final threadsModelTopicInfo = ThreadsReply().obs;
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  final heroTagAddition = ''.obs;
  final topicId = 0.obs;
  final isOnLoad = false.obs;
  final isOnlyPoDisplay = false.obs;

  int _currentLoadedPage = 0;
  TopicInfo originalTopicInfo = TopicInfo();
  String poCookie = '';

  Map contentMap = {}.obs;
  int currentPage = 0;
  int totalPage = 1;

  @override
  void onInit() {
    super.onInit();
    Logger().i('ContentController init');
    // loadContent();
  }

  @override
  void onReady() {
    Logger().i('ContentController onReady');
    super.onReady();
  }

  @override
  void onClose() {
    Logger().i('ContentController onClose');
  }

  // arguments passed in view
  // use this function to init paramaters
  void openNewContent(ContentArgumentModel model) async {
    if (originalTopicInfo != model.topicData) {
      originalTopicInfo = model.topicData!;
      totalPage = originalTopicInfo.replyCount!;
      threadsModelTopicInfo.value =
          transferTopicInfoToThreadsReply(originalTopicInfo);
      threadsModelTopicInfo.value.floor = 1;
      topicId.value = threadsModelTopicInfo.value.id!;
      contentList.add(threadsModelTopicInfo.value);
      heroTagAddition.value = model.heroType!;
      _currentLoadedPage = 0;
      poCookie = threadsModelTopicInfo.value.cookie!;
      loadContent();
    }
  }

  void loadContent() async {
    // TODO page load lock
    if (!isOnLoad.value) {
      _currentLoadedPage = _currentLoadedPage + 1;
      isOnLoad.value = true;
      try {
        await threadsProvider
            .postThreads(topicId.value, _currentLoadedPage)
            .then((result) {
          if (result.body is Map) {
            showWarnSnackBar('加载内容错误', '什么都没有啊');
          } else if (result.body is Threads) {
            totalPage = result.body.info!.replyCount!;
            result.body.info!.addFloor(_currentLoadedPage);
            contentList.addAll(result.body.info!.reply!);
            // Logger().i(contentList[1].floor);
          }
        });
      } catch (e) {
        rethrow;
      }

      isOnLoad.value = false;
    }
  }

  void refreshContent() {
    _currentLoadedPage = 0;
    contentList.value = [];
    contentList.add(threadsModelTopicInfo.value);
    loadContent();
  }

  bool switchOnlyPoDisplay() {
    isOnlyPoDisplay.value = !isOnlyPoDisplay.value;
    return isOnlyPoDisplay.value;
  }
}
