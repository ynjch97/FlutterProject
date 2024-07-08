import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/video_model.dart';

class TimelineViewModel extends AsyncNotifier<List<VideoModel>> {
  // List<VideoModel> _list = [VideoModel(title: "First video")];
  List<VideoModel> _list = [];

  // FutureOr : Future 또는 모델을 return
  @override
  FutureOr<List<VideoModel>> build() async {
    await Future.delayed(const Duration(seconds: 3));
    // throw Exception("can't fetch");
    return _list;
  }

  void uploadVideo() async {
    // loading state 가 되도록 함
    state = const AsyncValue.loading();
    await Future.delayed(const Duration(seconds: 2));

    // final newVideo = VideoModel(title: "${DateTime.now()}");
    // _list = [..._list, newVideo];
    _list = [..._list];

    // AsyncNotifier 안에서 State 를 대체할 때
    state = AsyncValue.data(_list);
  }
}

final timelineProvider =
    AsyncNotifierProvider<TimelineViewModel, List<VideoModel>>(
  () => TimelineViewModel(),
);
