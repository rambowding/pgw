import 'package:flutter/foundation.dart';

/// 箭头区的model
class ArrowAreaModel with ChangeNotifier {
  /// true表示显示左边箭头，false表示显示后边箭头
  bool isLeft = true;

  void update(bool left) {
    // 重复点击，不做更新操作
    if (isLeft == left) return;

    isLeft = left;
    notifyListeners();
  }
}