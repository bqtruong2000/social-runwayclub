import 'package:flutter/material.dart';
import 'package:runway_club_social/http/articles.dart';
import '../../app/news_page/news_page.dart';

// var postdata = [
//   {
//     'id': 0,
//     'postContent':
//         'HTML là một ngôn ngữ đánh dấu được thiết kế ra để tạo nên các trang web trên World Wide Web. HTML được tạo ra bởi Tim Berners-Lee vào năm 1990-1991. HTML là viết tắt của cụm từ tiếng Anh HyperText Markup Language, có nghĩa là "Ngôn ngữ đánh dấu siêu văn bản".',
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

class MySearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<Article>>(
      future: postdataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Hiển thị loading indicator trong quá trình tải dữ liệu
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // Xử lý khi có lỗi xảy ra
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          // Xử lý khi không có dữ liệu
          return const Text('No data found');
        } else {
          // Xử lý khi có dữ liệu và không có lỗi
          final searchData = query.toLowerCase();
          final searchResults = snapshot.data!.where((post) {
            final postName = post.postName.toLowerCase();
            return postName.contains(searchData);
          }).toList();

          return SingleChildScrollView(
            child: Center(
              child: Column(
                children: searchResults.map((post) {
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
                        uid: post.uid,
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List<Article>>(
      future: postdataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No suggestions found'));
        } else {
          final suggestions = snapshot.data!.where((post) {
            final postName = post.postName.toLowerCase();
            final searchData = query.toLowerCase();
            return postName.contains(searchData);
          }).toList();

          return ListView.builder(
            itemCount: suggestions.length,
            itemBuilder: (context, index) {
              final post = suggestions[index];
              return ListTile(
                title: Text(post.postName),
                onTap: () {
                  query = post
                      .postName; // Cập nhật query khi người dùng chọn một gợi ý
                },
              );
            },
          );
        }
      },
    );
  }
}
