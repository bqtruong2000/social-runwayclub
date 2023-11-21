import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../reading_list_page/controller/reading_list_controller.dart';
import '../../widgets/postcard_sumary.dart';

// ignore: must_be_immutable
class ReadingListPage extends StatelessWidget {
  var postdata = [
    {
      'id': 0,
      'postContent':
      'HTML là một ngôn ngữ đánh dấu được thiết kế ra để tạo nên các trang web trên World Wide Web. HTML được tạo ra bởi Tim Berners-Lee vào năm 1990-1991. HTML là viết tắt của cụm từ tiếng Anh HyperText Markup Language, có nghĩa là "Ngôn ngữ đánh dấu siêu văn bản".',
      'postDate': DateTime(2023, 9, 9),
      'postImagePath': 'assets/images/postimage1.png',
      'postName': 'HTML, CSS, JavaScript là gì?',
      'posterAvatarPath': 'assets/images/avt1.jpg',
      'posterName': 'thanhhuy5902',
      'tag': 'web'
    },
    {
      'id': 1,
      'postContent': 'Hi',
      'postDate': DateTime(2023, 10, 30),
      'postImagePath': 'assets/images/postimage2.png',
      'postName': 'Chào mừng đến với Runway club',
      'posterAvatarPath': 'assets/images/avt2.jpg',
      'posterName': 'truk',
      'tag': 'welcome'
    },
    {
      'id': 2,
      'postContent': 'Hi',
      'postDate': DateTime(2023, 10, 31),
      'postImagePath': 'assets/images/postimage2.png',
      'postName': 'Chào mừng đến với Runway club',
      'posterAvatarPath': 'assets/images/avt2.jpg',
      'posterName': 'truk',
      'tag': 'welcome'
    },
  ];
  var tag = [];
  ReadingListPage({super.key}) {
    tag = postdata.map((e) => '#${e['tag']}').toSet().toList();
    tag.insert(0, 'All');
  }
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
              child: Obx(
                    () => Column(
                  children: postdata
                      .where((element) => c.checkState[element['id']] == true)
                      .map((postdata) {
                    return Column(
                      children: [
                        const SizedBox(height: 10),
                        PostCard(
                          id: postdata['id'] as int,
                          postImagePath: postdata['postImagePath'].toString(),
                          postName: postdata['postName'].toString(),
                          tag: postdata['tag'].toString(),
                          posterName: postdata['posterName'].toString(),
                          posterAvatarPath:
                          postdata['posterAvatarPath'].toString(),
                          postDate: postdata['postDate'] as DateTime,
                          postContent: postdata['postContent'].toString(),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Center(
              child: Obx(
                    () => Column(
                  children: postdata
                      .where((element) =>
                  c.checkState[element['id']] == true &&
                      element['tag'] == 'web')
                      .map((postdata) {
                    return Column(
                      children: [
                        const SizedBox(height: 10),
                        PostCard(
                          id: postdata['id'] as int,
                          postImagePath: postdata['postImagePath'].toString(),
                          postName: postdata['postName'].toString(),
                          tag: postdata['tag'].toString(),
                          posterName: postdata['posterName'].toString(),
                          posterAvatarPath:
                          postdata['posterAvatarPath'].toString(),
                          postDate: postdata['postDate'] as DateTime,
                          postContent: postdata['postContent'].toString(),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Center(
              child: Obx(
                    () => Column(
                  children: postdata
                      .where((element) =>
                  c.checkState[element['id']] == true &&
                      element['tag'] == 'welcome')
                      .map((postdata) {
                    return Column(
                      children: [
                        const SizedBox(height: 10),
                        PostCard(
                          id: postdata['id'] as int,
                          postImagePath: postdata['postImagePath'].toString(),
                          postName: postdata['postName'].toString(),
                          tag: postdata['tag'].toString(),
                          posterName: postdata['posterName'].toString(),
                          posterAvatarPath:
                          postdata['posterAvatarPath'].toString(),
                          postDate: postdata['postDate'] as DateTime,
                          postContent: postdata['postContent'].toString(),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
