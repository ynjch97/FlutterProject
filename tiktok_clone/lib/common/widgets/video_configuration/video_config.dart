// ignore_for_file: slash_for_doc_comments

import 'package:flutter/widgets.dart';

// 20.6 video_post.dart 에서 autoMute 값을 알도록 함
class VideoConfigData extends InheritedWidget {
  final bool autoMute;
  final void Function() toggleMuted;

  const VideoConfigData({
    super.key,
    required this.autoMute,
    required this.toggleMuted,
    required super.child,
  });

  /**VideoConfigData 로 접근할 수 있는 직접적인 링크 필요
   * - dependOnInheritedWidgetOfExactType : VideoConfigData 라는 이름의 InheritedWidget 을 가져오도록 함
   * - of Constructor 생성하여 간단하게 접근하게 함
   */
  static VideoConfigData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<VideoConfigData>()!;
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

// 20.7 InheritedWidget + StatefulWidget 결합 (데이터 변경하는 메소드 사용을 위해 필요)
// 데이터는 StatefulWidget 이 주고 -> InheritedWidget 은 데이터와 데이터 수정 메소드에 접근할 권한을 줌
class VideoConfig extends StatefulWidget {
  final Widget child;

  const VideoConfig({
    super.key,
    required this.child,
  });

  @override
  State<VideoConfig> createState() => _VideoConfigState();
}

class _VideoConfigState extends State<VideoConfig> {
  bool autoMute = false;

  // InheritedWidget 로 데이터를 공유, StatefulWidget 함수로 데이터를 수정
  void toggleMuted() {
    setState(() {
      autoMute = !autoMute;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 새로운 데이터와 함께 rebuild
    return VideoConfigData(
      autoMute: autoMute,
      toggleMuted: toggleMuted,
      child: widget.child,
    );
  }
}
