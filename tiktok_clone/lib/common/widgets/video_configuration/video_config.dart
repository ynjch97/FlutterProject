// ignore_for_file: slash_for_doc_comments

import 'package:flutter/widgets.dart';

// 20.6 video_post.dart 에서 autoMute 값을 알도록 함
class VideoConfig extends InheritedWidget {
  const VideoConfig({
    super.key,
    required super.child,
  });

  final bool autoMute = true;

  /**VideoConfig 로 접근할 수 있는 직접적인 링크 필요
   * - dependOnInheritedWidgetOfExactType : VideoConfig 라는 이름의 InheritedWidget 을 가져오도록 함
   * - of Constructor 생성하여 간단하게 접근하게 함
   */
  static VideoConfig of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<VideoConfig>()!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    /**위젯을 rebuild 할지 말지를 정할 수 있게 해줌
     * - 이 위젯을 다시 render 하면, oldWidget 의 state 를 가질 수 있음
     * - 이 위젯을 상속하는 위젯들에게 알려줄 것인가를 결정
     * - 이 위젯을 rebuild 시, 상속하는 위젯들도 rebuild 해야할 수도 있음
     */
    return true;
  }
}
