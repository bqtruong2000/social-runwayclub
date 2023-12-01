import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:runway_club_social/http/articles.dart';
import '../reading_list_page/controller/reading_list_controller.dart';
import '../../widgets/postcard_sumary.dart';

// ignore: must_be_immutable
class ReadingListPage extends StatelessWidget {
  var tag = [];

  ReadingListPage({super.key});

  @override
  Widget build(BuildContext context) {
    ReadingListController c = Get.put(ReadingListController());
    final theme = Theme.of(context);
    return DefaultTabController(
      length: tag.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Reading List'),
          bottom: TabBar(
            isScrollable: true,
            labelStyle: theme.textTheme.bodyLarge
                ?.copyWith(fontWeight: FontWeight.bold),
            labelColor: Colors.black,
            unselectedLabelStyle: theme.textTheme.bodyLarge
                ?.copyWith(fontWeight: FontWeight.bold),
            unselectedLabelColor: Colors.black.withOpacity(0.5),
            tabs: tag.map((tagItem) => Tab(text: tagItem)).toList(),
          ),
          backgroundColor: theme.colorScheme.background,
        ),
        body: TabBarView(children: [
          SingleChildScrollView(
            child: Center(
              child: FutureBuilder<List<Article>>(
                future: postdataFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(); // Hiển thị khi đang chờ dữ liệu
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}'); // Xử lý lỗi nếu có
                  } else {
                    List<Article> postdata =
                        snapshot.data!; // Lấy dữ liệu từ snapshot
                    List<Widget> postWidgets = postdata
                        .where((element) => c.checkState[element.id] == true)
                        .map((post) {
                      return Column(
                        children: [
                          const SizedBox(height: 10),
                          PostCard(
                            id: post.id,
                            postImagePath: post.postImagePath,
                            postName: post.postName,
                            tags: post.tags,
                            posterName: post.posterName,
                            posterAvatarPath: post.posterAvatarPath,
                            postDate: post.postDate,
                            postDescription: post.postDescription,
                          ),
                        ],
                      );
                    }).toList();

                    return Column(
                      children: postWidgets, // Hiển thị danh sách các widgets
                    );
                  }
                },
              ),
            ),
          ),
          SingleChildScrollView(
            child: Center(
              child: FutureBuilder<List<Article>>(
                future: postdataFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(); // Hiển thị khi đang chờ dữ liệu
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}'); // Xử lý lỗi nếu có
                  } else {
                    List<Article> postdata =
                        snapshot.data!; // Lấy dữ liệu từ snapshot
                    List<Widget> postWidgets = postdata
                        .where((element) => c.checkState[element.id] == true)
                        .map((post) {
                      return Column(
                        children: [
                          const SizedBox(height: 10),
                          PostCard(
                            id: post.id,
                            postImagePath: post.postImagePath,
                            postName: post.postName,
                            tags: post.tags,
                            posterName: post.posterName,
                            posterAvatarPath: post.posterAvatarPath,
                            postDate: post.postDate,
                            postDescription: post.postDescription,
                          ),
                        ],
                      );
                    }).toList();

                    return Column(
                      children: postWidgets, // Hiển thị danh sách các widgets
                    );
                  }
                },
              ),
            ),
          ),
          SingleChildScrollView(
            child: Center(
              child: FutureBuilder<List<Article>>(
                future: postdataFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(); // Hiển thị khi đang chờ dữ liệu
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}'); // Xử lý lỗi nếu có
                  } else {
                    List<Article> postdata =
                        snapshot.data!; // Lấy dữ liệu từ snapshot
                    List<Widget> postWidgets = postdata
                        .where((element) => c.checkState[element.id] == true)
                        .map((post) {
                      return Column(
                        children: [
                          const SizedBox(height: 10),
                          PostCard(
                            id: post.id,
                            postImagePath: post.postImagePath,
                            postName: post.postName,
                            tags: post.tags,
                            posterName: post.posterName,
                            posterAvatarPath: post.posterAvatarPath,
                            postDate: post.postDate,
                            postDescription: post.postDescription,
                          ),
                        ],
                      );
                    }).toList();

                    return Column(
                      children: postWidgets, // Hiển thị danh sách các widgets
                    );
                  }
                },
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
