import 'package:flutter/material.dart';
import '../../app/news_page/news_page.dart';

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
    final searchResults = postdata.where((post) {
      final postName = post['postName'].toString().toLowerCase();
      final searchData = query.toLowerCase();
      return postName.contains(searchData);
    }).toList();
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: searchResults.map((postdata) {
            return Column(
              children: [
                const SizedBox(height: 10),
                PostCard(
                  id: postdata['id'] as int,
                  postImagePath: postdata['postImagePath'].toString(),
                  postName: postdata['postName'].toString(),
                  tag: postdata['tag'].toString(),
                  posterName: postdata['posterName'].toString(),
                  posterAvatarPath: postdata['posterAvatarPath'].toString(),
                  postDate: postdata['postDate'] as DateTime,
                  postContent: postdata['postContent'].toString(),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Trả về các gợi ý tìm kiếm dựa trên giá trị của query
    final suggestions = postdata.where((post) {
      final postName = post['postName'].toString().toLowerCase();
      final searchData = query.toLowerCase();
      return postName.contains(searchData);
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final post = suggestions[index];
        return ListTile(
          title: Text(post['postName'].toString()),
          onTap: () {
            // Xử lý khi người dùng chọn một gợi ý
            // Ví dụ: cập nhật query và hiển thị kết quả tương ứng
            query = post['postName'].toString();
          },
        );
      },
    );
  }
}