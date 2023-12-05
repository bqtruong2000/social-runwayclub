import 'package:get/get.dart';
import '../../../http/articles.dart';


class BlogController extends GetxController {
  var commentText = ''.obs;
  var comments = <String>[].obs;

  final article = Article(
    id: 0,
    postImagePath: '',
    postName: '',
    tags: [],
    posterName: '',
    posterAvatarPath: '',
    postDate: '',
    postDescription: '',
  ).obs;

  void setComment(String text) {
    commentText.value = text;
  }

  void addComment() {
    if (commentText.isNotEmpty) {
      comments.add(commentText.value);
      commentText.value = '';
      update(); // Trigger UI update
    }
  }
}