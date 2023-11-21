import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../app/reading_list_page/controller/reading_list_controller.dart';

class PostCard extends StatelessWidget {
  const PostCard({
    super.key,
    required this.id,
    required this.postImagePath,
    required this.postName,
    required this.tag,
    required this.posterName,
    required this.posterAvatarPath,
    required this.postDate,
    required this.postContent,
  });

  final int id; //index để phân biệt các card trong controller
  final String postImagePath;
  final String postName;
  final String tag;
  final String posterName;
  final String posterAvatarPath;
  final DateTime postDate;
  final String postContent;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var widthCard = screenWidth * 0.94;
    final theme = Theme.of(context);
    ReadingListController c = Get.put(ReadingListController());

    return SizedBox(
      width: widthCard,
      child: Card(
        surfaceTintColor: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(posterAvatarPath),
                    radius: 20,
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: screenWidth * 0.63,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(posterName,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold)),
                        Text(DateFormat("MMM d''yy").format(postDate),
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withOpacity(0.5))),
                      ],
                    ),
                  ),
                  Obx(
                        () => IconButton(
                      onPressed: () {
                        // Sử dụng index để xác định card cụ thể được nhấn
                        c.updateCheckState(id, !c.checkState[id]!);
                        if (c.checkState[id]!) {
                          c.updateIcon(id, Icons.bookmark);
                        } else {
                          c.updateIcon(id, Icons.bookmark_outline);
                        }
                      },
                      icon: Icon(c.icon[id]), // Sử dụng icon theo index
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(postName,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  Text('#$tag',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.primary)),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
