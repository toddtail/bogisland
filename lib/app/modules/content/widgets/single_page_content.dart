import 'package:bog_island/app/modules/content/controllers/content_controller.dart';
import 'package:bog_island/app/modules/content/models/threads_model.dart';
import 'package:bog_island/app/modules/content/widgets/content_card_new.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paginated_items_builder/paginated_items_builder.dart';

class ContentSinglePage extends StatelessWidget {
  ContentSinglePage(this.page, {Key? key}) : super(key: key);

  final int page;
  final ContentController controller = Get.find<ContentController>();
  @override
  Widget build(BuildContext context) {
    return PaginatedItemsBuilder<ThreadsReply>(
      fetchPageData: (reset, itemsFetchScope) => controller.postThreadsInPaginated(page),
      response: controller.contentMapPaginated[page],
      itemBuilder: (context, index, item) => ContentCardNew(item),
    );
  }
}
