import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app/blog_page/controllers/blog_controller.dart';
import '../../http/articles.dart';
import '../../http/user_article.dart';


class BlogPage extends StatelessWidget {
  final Article article;

  BlogPage({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) => FutureBuilder<Blog>(
        future: fetchBlog(article.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Display loading indicator while fetching data
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}'); // Handle error if any
          } else {
            Blog blog = snapshot.data!; // Retrieved blog data
      return Scaffold(
        appBar: AppBar(

          centerTitle: true,
          actions: <Widget>[
            Container(
              width: 200.0,
              margin: const EdgeInsets.only(right: 90.0),
              child:  Row(

                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(article.posterAvatarPath),
                    radius: 20,
                  ),

                  SizedBox(width: 10),
                  Text(blog.blogUserName, style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
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
              children: [
                const SizedBox(height: 10),
                MyImageWidget(blog: blog),
              ],
            ),
          ),

        ),
      );
    }
}
    );
}


class MyImageWidget extends StatelessWidget {
  final Blog blog;
  final BlogController c = Get.put(BlogController());

  MyImageWidget({required this.blog});

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
            child: Image.network(blog.blogImage),
          ),
          SizedBox(height: 16.0),
          const Divider(height: 1.0, thickness: 0.5),
          SizedBox(height: 16.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Publish at ' + blog.blogPublishedAt,
                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal),
                ),
                SizedBox(height: 8.0),
                Text(
                  blog.blogTitle,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),

              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            alignment: Alignment.center,
            child: Text(
              // article.postDescription
              blog.blogContent
              ,style: TextStyle(fontSize: 16.0),
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