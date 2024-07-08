import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/videos/repos/videos_repo.dart';

class UploadVideoViewModel extends AsyncNotifier<void> {
  late final VideosRepository _repository;

  @override
  FutureOr<void> build() {
    _repository = ref.read(videosRepo); // repository 초기화
  }

  Future<void> uploadVideo(File video) async {
    final user = ref.read(authRepo).user;

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      // uploadVideoFile: UploadTask 타입으로 반환됨
      final task = await _repository.uploadVideoFile(
        video,
        user!.uid,
      );
      // metadata 확인, null 이 아니면 성공적으로 업로드 되었다는 뜻
      if (task.metadata != null) {
        // await _repository.saveVideo();
      }
    });
  }
}
