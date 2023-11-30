// ignore: file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:runway_club_social/app/blog_page/blog_page.dart';
import 'package:runway_club_social/http/articles.dart';
import '../../app/search_page/search_page.dart';
import 'package:intl/intl.dart';

import '../reading_list_page/controller/reading_list_controller.dart';

class NewsPage extends StatelessWidget {
  NewsPage({super.key});

  // var postdata = [
  //   {
  //     'id': 0,
  //     'postContent':
  //     'HTML là một ngôn ngữ đánh dấu được thiết kế ra để tạo nên các trang web trên World Wide Web. HTML được tạo ra bởi Tim Berners-Lee vào năm 1990-1991. HTML là viết tắt của cụm từ tiếng Anh HyperText Markup Language, có nghĩa là "Ngôn ngữ đánh dấu siêu văn bản".',
  //     'postDate': DateTime(2023, 9, 9),
  //     'postImagePath': 'assets/images/postimage1.png',
  //     'postName': 'HTML, CSS, JavaScript là gì?',
  //     'posterAvatarPath': 'assets/images/avt1.jpg',
  //     'posterName': 'thanhhuy5902',
  //     'tag': 'web'
  //   },
  //   {
  //     'id': 1,
  //     'postContent': 'Hi',
  //     'postDate': DateTime(2023, 10, 30),
  //     'postImagePath': 'assets/images/postimage2.png',
  //     'postName': 'Chào mừng đến với Runway club',
  //     'posterAvatarPath': 'assets/images/avt2.jpg',
  //     'posterName': 'truk',
  //     'tag': 'welcome'
  //   },
  //   {
  //     'id': 2,
  //     'postContent': 'Hi',
  //     'postDate': DateTime(2023, 10, 31),
  //     'postImagePath': 'assets/images/postimage2.png',
  //     'postName': 'Chào mừng đến với Runway club',
  //     'posterAvatarPath': 'assets/images/avt2.jpg',
  //     'posterName': 'truk',
  //     'tag': 'welcome'
  //   },
  // ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DefaultTabController(
        length: 3,
        initialIndex: 0,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              'Runway Club',
              style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: MySearchDelegate(),
                  );
                },
                icon: const Icon(Icons.search),
                color: theme.colorScheme.primary,
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/readingList');
                },
                icon: const Icon(Icons.bookmark),
                color: theme.colorScheme.primary,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_vert),
                color: theme.colorScheme.primary,
              ),
            ],
            bottom: TabBar(
              labelStyle: theme.textTheme.bodyLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
              labelColor: Colors.black,
              unselectedLabelStyle: theme.textTheme.bodyLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
              unselectedLabelColor: Colors.black.withOpacity(0.5),
              tabs: const [
                Tab(text: 'Relavant'),
                Tab(text: 'Latest'),
                Tab(text: 'Top'),
              ],
            ),
            backgroundColor: theme.colorScheme.background,
          ),
          body: TabBarView(
            children: [
              SingleChildScrollView(
                child: Center(
                  child: FutureBuilder<List<Article>>(
                    future: postdataFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator(); // Hiển thị khi đang chờ dữ liệu
                      } else if (snapshot.hasError) {
                        return Text(
                            'Error: ${snapshot.error}'); // Xử lý lỗi nếu có
                      } else {
                        List<Article> postdata =
                            snapshot.data!; // Lấy dữ liệu từ snapshot
                        List<Widget> postWidgets = postdata.map((post) {
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
                          children:
                              postWidgets, // Hiển thị danh sách các widgets
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
                        return CircularProgressIndicator(); // Hiển thị khi đang chờ dữ liệu
                      } else if (snapshot.hasError) {
                        return Text(
                            'Error: ${snapshot.error}'); // Xử lý lỗi nếu có
                      } else {
                        List<Article> postdata =
                            snapshot.data!; // Lấy dữ liệu từ snapshot
                        List<Widget> postWidgets = postdata.map((post) {
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
                          children:
                              postWidgets, // Hiển thị danh sách các widgets
                        );
                      }
                    },
                  ),
                ),
              ),
              Container(
                child: Center(
                  child: Text('Top'),
                ),
              ),
            ],
          ),
        ));
  }
}

class PostCard extends StatelessWidget {
  const PostCard({
    super.key,
    required this.id,
    required this.postImagePath,
    required this.postName,
    required this.tags,
    required this.posterName,
    required this.posterAvatarPath,
    required this.postDate,
    required this.postDescription,
  });

  final int id; //index để phân biệt các card trong controller
  final String postImagePath;
  final String postName;
  final List<String> tags;
  final String posterName;
  final String posterAvatarPath;
  final String postDate;
  final String postDescription;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var widthCard = screenWidth * 0.94;
    final theme = Theme.of(context);
    ReadingListController c = Get.put(ReadingListController());

    return GestureDetector(
      onTap: () {
        // Navigate to BlogApp() here
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BlogPage()),
        );
      },
      child: SizedBox(
        width: widthCard,
        child: Card(
          surfaceTintColor: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
                child: Center(
                    child: Image.network(
                  postImagePath,
                  width: widthCard - 30,
                  height: 182,
                )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(posterAvatarPath),
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
                          Text(postDate,
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
                    Text(tags.map((tag) => '#$tag').join(', '),
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).colorScheme.primary)),
                    const SizedBox(height: 10),
                    Text(
                      postDescription,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
