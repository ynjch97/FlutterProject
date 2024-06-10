// ignore_for_file: slash_for_doc_comments

import 'package:flutter/widgets.dart';

// 20.9 ChangeNotifier 사용
/*
class VideoConfig extends ChangeNotifier {
  bool autoMute = true;

  void toggleAutoMute() {
    autoMute = !autoMute;
    notifyListeners();
  }
}

final videoConfig = VideoConfig();
*/

// 20.10 ValueNotifier
final videoConfig = ValueNotifier(true);
