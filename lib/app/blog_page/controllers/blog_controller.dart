import 'package:get/get.dart';


class BlogController extends GetxController {
  var commentText = ''.obs;
  var comments = <String>[].obs;

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