import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../app/blog_page/controllers/blog_controller.dart';


class BlogPage extends StatelessWidget {
  BlogPage({Key? key}) : super(key: key);

  var postdata = [
  {
  'postContent':
  'HTML là một ngôn ngữ đánh dấu được thiết kế ra để tạo nên các trang web trên World Wide Web. HTML được tạo ra bởi Tim Berners-Lee vào năm 1990-1991. HTML là viết tắt của cụm từ tiếng Anh HyperText Markup Language, có nghĩa là "Ngôn ngữ đánh dấu siêu văn bản".',
  'postDate': DateTime(2023, 9, 9),
  'postImagePath': 'assets/images/postimage1.png',
  'postName': 'HTML, CSS, JavaScript là gì?',
  'posterAvatarPath': 'assets/images/avt2.jpg',
  'posterName': 'thanhtruk',
  'tag': 'web'
},];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        centerTitle: true,
        actions: <Widget>[
          Container(
            width: 200.0,
            margin: const EdgeInsets.only(right: 90.0),
            child: const Row(

              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/avt2.jpg'),
                  radius: 20,
                ),

                SizedBox(width: 10),
                Text('thanhtruk', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
              ],

            ),
          ),

          IconButton(
            padding: const EdgeInsets.only(right: 10.0),
            onPressed: () {},
            icon: const Icon(Icons.more_horiz),
            color: Colors.black,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: postdata.map((postdata) {
              return Column(
                children: [
                  const SizedBox(height: 10),
                  MyImageWidget(),

                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}


class PostCard extends StatelessWidget {
  const PostCard({
    super.key,
    required this.postImagePath,
    required this.postName,
    required this.tag,
    required this.posterName,
    required this.posterAvatarPath,
    required this.postDate,
    required this.postContent,
  });

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
    var width = screenWidth * 0.94;

    return SizedBox(
      width: width,
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
                  child: Image.asset(postImagePath,
                      width: width - 30, height: 182)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(posterAvatarPath),
                    radius: 20,
                  ),
                  const SizedBox(width: 10),
                  Column(
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
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 0, 10),
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
                  Text(
                    postContent,
                    style: Theme.of(context).textTheme.bodyLarge,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyImageWidget extends StatelessWidget {
  final BlogController c = Get.put(BlogController());
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
    SingleChildScrollView(
    child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 250.0, // Set your desired height here
            width: MediaQuery.of(context).size.width,
            child: Image.asset('assets/images/postimage2.png'),
          ),
          SizedBox(height: 16.0),
          const Divider(height: 1.0, thickness: 0.5),
          SizedBox(height: 16.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Chào mừng các bạn',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 8.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            alignment: Alignment.center,
            child: Text(
              'Chúng tôi rất vui mừng và tự hào khi bạn đã quyết định gia nhập gia đình Runway. Đây không chỉ là một câu lạc bộ, mà còn là một cộng đồng đam mê nơi mà chúng ta cùng nhau chia sẻ niềm đam mê về lập trình.\nHãy chuẩn bị sẵn sàng cho một cuộc hành trình đầy hứng thú và đổi mới tại Runway Club. Chúng tôi tin chắc rằng bạn sẽ tìm thấy nhiều cơ hội thú vị và kỷ niệm đáng nhớ tại đây. Đừng ngần ngại tham gia vào các hoạt động, tạo dựng mối quan hệ và thảo luận về lập trình cùng chúng tôi.',
              style: TextStyle(fontSize: 16.0),
            ),
          ),


          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GetBuilder<BlogController>(
              builder: (_) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: c.comments
                    .map((comment) => CommentCard(comment: comment))
                    .toList(),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: c.setComment,
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Your comment',
                suffixIcon: IconButton(
                  onPressed: () {
                    c.addComment();
                    FocusScope.of(context).unfocus(); // Dismiss the keyboard
                  },
                  icon: Icon(Icons.send),
                  color: Color(0xFF426ef0),
                ),
              ),
            ),
          ),


        ],
      ),
    ),
        ],
    );
  }
}

class CommentCard extends StatelessWidget {
  final String comment;

  const CommentCard({required this.comment});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50.0,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        comment,
        style: TextStyle(fontSize: 16.0),
      ),
    );
  }
}