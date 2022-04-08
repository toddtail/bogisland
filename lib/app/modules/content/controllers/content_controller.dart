import 'package:bog_island/app/common/function/notify.dart';
import 'package:bog_island/app/common/function/topic_to_threads_transfer.dart';
import 'package:bog_island/app/modules/content/models/content_argument_model.dart';
import 'package:bog_island/app/modules/content/models/threads_model.dart';
import 'package:bog_island/app/modules/content/providers/threads_provider.dart';
import 'package:bog_island/app/modules/forum/models/topics_in_forum_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

enum LoadMode { top, bottom }

class ContentController extends GetxController {
  final threadsProvider = Get.find<ThreadsProvider>();
  final threadsModelTopicInfo = ThreadsReply().obs;
  final Logger logger = Logger();

  final heroTagAddition = ''.obs;
  final topicId = 0.obs;
  final isOnLoad = false.obs;
  final isOnlyPoDisplay = false.obs;

  TopicInfo originalTopicInfo = TopicInfo();
  String poCookie = '';

  final contentList = <ThreadsReply>[].obs;
  final contentNegativeList = <ThreadsReply>[].obs;
  final contentMap = <int, List<ThreadsReply>>{}.obs;

  final totalPage = 1.obs;
  int basePage = 1;
  final topPage = 1.obs;
  final bottomPage = 1.obs;

  int lastIndex = 1;
  int firstIndex = 1;
  final centerKey = const ValueKey('bottom_sliver');
  final _topWorkerCounter = 0.obs;
  late Worker topWorker;

  @override
  void onInit() {
    super.onInit();
    logger.i('ContentController init');
    topWorker = debounce(_topWorkerCounter, (latestValue) => loadContent(LoadMode.top),
        time: const Duration(milliseconds: 800));
  }

  @override
  void onReady() {
    logger.i('ContentController onReady');
    super.onReady();
  }

  @override
  void onClose() {
    logger.i('ContentController onClose');
    topWorker.dispose();
  }

  // arguments passed in view
  // use this function to init paramaters
  void openNewContent(ContentArgumentModel model) async {
    if (originalTopicInfo != model.topicData) {
      originalTopicInfo = model.topicData!;
      totalPage.value = originalTopicInfo.replyCount!;
      threadsModelTopicInfo.value =
          transferTopicInfoToThreadsReply(originalTopicInfo);
      threadsModelTopicInfo.value.floor = 1;
      threadsModelTopicInfo.value.page = 1;
      topicId.value = threadsModelTopicInfo.value.id!;
      contentList.add(threadsModelTopicInfo.value);
      heroTagAddition.value = model.heroType!;
      poCookie = threadsModelTopicInfo.value.cookie!;
      isOnLoad.value = true;
      bool loadResult = await loadContentMap(1);
      if (loadResult) {
        contentList.value = [];
        addContentFromMapToList(1, LoadMode.bottom);
      }
      isOnLoad.value = false;
    }
  }

  loadContent(LoadMode mode) async {
    if (!isOnLoad.value) {
      isOnLoad.value = true;
      // logger.i('loadContent at $mode');
      bool loadState;
      int loadPage;
      // logger.i('正在看第 $currentWatchPage 页');
      if (mode == LoadMode.top) {
        if (topPage > 1) {
          loadPage = topPage.value - 1;
          logger.i('LoadMode.top 正在loading $loadPage 页');
          loadState = await loadContentMap(loadPage);
          if (loadState) {
            addContentFromMapToList(loadPage, mode);
            topPage.value -= 1;
          }
        }
      } else if (mode == LoadMode.bottom) {
        if (bottomPage < totalPage.value) {
          loadPage = bottomPage.value + 1;
          logger.i('LoadMode.bottom 正在loading $loadPage 页');
          loadState = await loadContentMap(loadPage);
          if (loadState) {
            addContentFromMapToList(loadPage, mode);
            bottomPage.value += 1;
          }
        }
      }
      isOnLoad.value = false;
    }
  }

  // load content to map and refresh total page
  Future<bool> loadContentMap(int page) async {
    try {
      final result = await threadsProvider.postThreads(topicId.value, page);
      if (result.body is Threads) {
        totalPage.value = result.body.info!.replyCount! ~/ 20;
        result.body.info!.addFloorAndPage(page);
        contentMap[page] = result.body.info!.reply!;
        if (page == 1) {
          contentMap[page]?.insert(0, threadsModelTopicInfo.value);
        }
        return true;
      } else {
        // showWarnSnackBar('加载内容错误', '什么都没有啊');
        return false;
      }
    } catch (e) {
      showWarnSnackBar('加载内容失败', '请检查网络');
      return false;
    }
  }

  addContentFromMapToList(int page, LoadMode mode) {
    if (mode == LoadMode.top) {
      contentNegativeList.insertAll(
          contentNegativeList.length, contentMap[page]!.reversed.toList());
    } else if (mode == LoadMode.bottom) {
      contentList.insertAll(contentList.length, contentMap[page]!);
    }
    logger.i('contentList length: ${contentList.length}');
    logger.i('contentNegativeList length: ${contentNegativeList.length}');
    // contentList.refresh();
  }

  callTopLoadWorker() {
    _topWorkerCounter.value += 1;
  }

  //TODO
  loadContentAtBottom() async {
    int currentTotalPage = totalPage.value;
    loadContentMap(totalPage.value).then((value) {
      if (value && (currentTotalPage == totalPage.value)) {
        contentList.value = [];
        addContentFromMapToList(currentTotalPage, LoadMode.bottom);
      } else if (currentTotalPage < totalPage.value) {
        loadContentMap(totalPage.value).then((value) {
          if (value) {
            contentList.value = [];
            addContentFromMapToList(totalPage.value, LoadMode.bottom);
          }
        });
      }
    });
  }

  void jumpToFloor(int page) async {
    if (!isOnLoad.value) {
      isOnLoad.value = true;
      contentList.value = [];
      contentNegativeList.value = [];
      // contentList.refresh();
      bool loadState;
      loadState = await loadContentMap(page);
      if (loadState) {
        addContentFromMapToList(page, LoadMode.bottom);
        setPageVariable(page);
      }
      isOnLoad.value = false;
      // loadContent(LoadMode.top);
    }
  }

  void setPageVariable(int page) {
    basePage = page;
    topPage.value = page;
    bottomPage.value = page;
  }

  // load bottom content after post
  void refreshContent() async {
    await loadContentAtBottom();
  }

  bool switchOnlyPoDisplay() {
    isOnlyPoDisplay.value = !isOnlyPoDisplay.value;
    return isOnlyPoDisplay.value;
  }
}
