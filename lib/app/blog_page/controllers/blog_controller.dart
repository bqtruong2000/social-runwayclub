import 'package:get/get.dart';
import 'package:runway_club_social/app/profile_page/controller/profile_controller.dart';

import '../../../http/articles.dart';
import '../../../http/comment.dart';

class BlogController extends GetxController {
  var commentText = ''.obs;
  var comments = <String>[].obs;

  ProfileController profileController = Get.put(ProfileController());
  final article = Article(
    id: 0,
    postImagePath: '',
    postName: '',
    tags: [],
    posterName: '',
    posterAvatarPath: '',
    postDate: '',
    postDescription: '',
    uid: 0,
  ).obs;

  void setComment(String text) {
    commentText.value = text;
  }

  void addComment(
      String articleTitle, String articleOwner, int articleId) async {
    if (commentText.isNotEmpty) {
      Comment newComment = Comment(
          comment: commentText.value,
          articleTitle: articleTitle,
          articleId: articleId,
          articleOwner: articleOwner,
          userName: profileController.user.value.githubUserName,
          // Set the actual user name
          uid: profileController.user.value.uid,
          userImage: profileController
              .user.value.profileImage // Set the actual user ID
          );

      try {
        Comment createdComment = await createComment(newComment);
        comments.add(createdComment.comment);
        commentText.value = '';
        update(); // Trigger UI update
      } catch (e) {
        print('Error creating comment: $e');
        // Handle error
      }
    }
  }
}
