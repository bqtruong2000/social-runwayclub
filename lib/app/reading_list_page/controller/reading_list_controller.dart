import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReadingListController extends GetxController {
  //icon and checkstate in news page
  var checkState =
      <int, bool>{}.obs; // Dùng Map để lưu trạng thái của từng card
  var icon = <int, IconData>{}.obs; // Dùng Map để lưu icon của từng card

  // Các hàm để cập nhật trạng thái của từng card
  void updateCheckState(int id, bool newState) {
    checkState[id] = newState;
  }

  void updateIcon(int id, IconData newIcon) {
    icon[id] = newIcon;
  }

  @override
  void onInit() {
    super.onInit();
    // Khởi tạo giá trị false cho tất cả các phần tử trong checkState
    for (int i = 0; i < 10; i++) {
      checkState[i] = false;
    }

    // Khởi tạo giá trị Icons.bookmark_outline cho tất cả các phần tử trong icon
    for (int i = 0; i < 10; i++) {
      icon[i] = Icons.bookmark_outline;
    }
  }
}
