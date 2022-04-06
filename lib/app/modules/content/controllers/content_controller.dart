import 'package:bog_island/app/common/function/notify.dart';
import 'package:bog_island/app/common/function/topic_to_threads_transfer.dart';
import 'package:bog_island/app/modules/content/models/content_argument_model.dart';
import 'package:bog_island/app/modules/content/models/threads_model.dart';
import 'package:bog_island/app/modules/content/providers/threads_provider.dart';
import 'package:bog_island/app/modules/forum/models/topics_in_forum_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:paginated_items_builder/paginated_items_builder.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

enum LoadMode { top, bottom }

class ContentController extends GetxController {
  final threadsProvider = Get.find<ThreadsProvider>();
  final contentList = <ThreadsReply>[].obs;
  final threadsModelTopicInfo = ThreadsReply().obs;
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  final Logger logger = Logger();

  final heroTagAddition = ''.obs;
  final topicId = 0.obs;
  final isOnLoad = false.obs;
  final isOnlyPoDisplay = false.obs;

  TopicInfo originalTopicInfo = TopicInfo();
  String poCookie = '';

  final contentMap = <int, List<ThreadsReply>>{}.obs;
  final contentMapPaginated = <int, PaginatedItemsResponse<ThreadsReply>>{}.obs;
  int currentWatchPage = 1;
  int totalPage = 1;
  int lastIndex = 1;
  int firstIndex = 1;

  @override
  void onInit() {
    super.onInit();
    logger.i('ContentController init');
    // loadContent();
    itemPositionsListener.itemPositions.addListener(() {
      lastIndex = itemPositionsListener.itemPositions.value.last.index;
      firstIndex = itemPositionsListener.itemPositions.value.first.index;
      int lastIndexPage = contentList[lastIndex].page!;
      if (currentWatchPage != lastIndexPage) {
        currentWatchPage = lastIndexPage;
        // logger.i(contentList.length);
        // logger.i('最后的index $lastIndexFloor');
        // logger.i('正在看第 $currentWatchPage 页');
      }
    });
  }

  @override
  void onReady() {
    logger.i('ContentController onReady');
    super.onReady();
  }

  @override
  void onClose() {
    logger.i('ContentController onClose');
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
      threadsModelTopicInfo.value.page = 1;
      topicId.value = threadsModelTopicInfo.value.id!;
      contentList.add(threadsModelTopicInfo.value);
      heroTagAddition.value = model.heroType!;
      poCookie = threadsModelTopicInfo.value.cookie!;
      isOnLoad.value = true;
      bool loadResult = await loadContentMap(1);
      if (loadResult) {
        contentList.value = [];
        addContentFromMapToList(1, LoadMode.top);
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
        if (currentWatchPage > 1) {
          loadPage = currentWatchPage - 1;
          loadState = await loadContentMap(loadPage);
          if (loadState) {
            addContentFromMapToList(loadPage, mode);
            itemScrollController.jumpTo(index: firstIndex + 20);
          }
        }
      } else if (mode == LoadMode.bottom) {
        if (currentWatchPage < totalPage) {
          loadPage = currentWatchPage + 1;
          loadState = await loadContentMap(loadPage);
          if (loadState) {
            addContentFromMapToList(loadPage, mode);
          }
        }
      }
      isOnLoad.value = false;
    }
  }

  Future<PaginatedItemsResponse<ThreadsReply>?> postThreadsInPaginated(
      int page) async {
    final result = await threadsProvider.postThreads(topicId.value, page);
    if (result.body is Threads) {
      totalPage = result.body.info!.replyCount!;
      result.body.info!.addFloorAndPage(page);
      contentMap[page] = result.body.info!.reply!;
      if (page == 1) {
        contentMap[page]?.insert(0, threadsModelTopicInfo.value);
      }
      final item = PaginatedItemsResponse<ThreadsReply>(
        listItems: contentMap[page],
        // no support for pagination for current api
        paginationKey: null,
        idGetter: (post) => post.id.toString(),
      );
      contentMapPaginated[page] = item;
      return item;
    } else {
      return PaginatedItemsResponse<ThreadsReply>(
        listItems: [],
        idGetter: (post) => post.id.toString(),
      );
    }
  }

  Future<bool> loadContentMap(int page) async {
    try {
      final result = await threadsProvider.postThreads(topicId.value, page);
      if (result.body is Threads) {
        totalPage = result.body.info!.replyCount!;
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
      contentList.insertAll(0, contentMap[page]!);
    } else if (mode == LoadMode.bottom) {
      contentList.insertAll(contentList.length, contentMap[page]!);
    }
    contentList.refresh();
  }

  loadContentAtBottom() async {
    int currentTotalPage = totalPage;
    loadContentMap(totalPage).then((value) {
      if (value && (currentTotalPage == totalPage)) {
        contentList.value = [];
        addContentFromMapToList(currentTotalPage, LoadMode.top);
      } else if (currentTotalPage < totalPage) {
        loadContentMap(totalPage).then((value) {
          if (value) {
            contentList.value = [];
            addContentFromMapToList(totalPage, LoadMode.top);
          }
        });
      }
    });
  }

  void jumpToFloor(int page) async {
    if (!isOnLoad.value) {
      isOnLoad.value = true;
      contentList.value = [];
      contentList.refresh();
      bool loadState;
      loadState = await loadContentMap(page);
      if (loadState) {
        addContentFromMapToList(page, LoadMode.top);
      }
      isOnLoad.value = false;
      // itemScrollController.scrollTo(
      //     index: index,
      //     duration: const Duration(milliseconds: 200),
      //     curve: Curves.easeInOutCubic);
    }
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
