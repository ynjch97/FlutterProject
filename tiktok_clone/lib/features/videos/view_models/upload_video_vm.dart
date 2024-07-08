import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/users/view_models/users_view_model.dart';
import 'package:tiktok_clone/features/videos/models/video_model.dart';
import 'package:tiktok_clone/features/videos/repos/videos_repo.dart';

class UploadVideoViewModel extends AsyncNotifier<void> {
  late final VideosRepository _repository;

  @override
  FutureOr<void> build() {
    _repository = ref.read(videosRepo); // repository 초기화
  }

  Future<void> uploadVideo(File video, BuildContext context) async {
    final user = ref.read(authRepo).user;
    final userProfile = ref.read(userProvider).value;
    if (userProfile != null) {
      state = const AsyncValue.loading();
      state = await AsyncValue.guard(() async {
        // uploadVideoFile: UploadTask 타입으로 반환됨
        final task = await _repository.uploadVideoFile(
          video,
          user!.uid,
        );
        // metadata 확인, null 이 아니면 성공적으로 업로드 되었다는 뜻
        if (task.metadata != null) {
          // saveVideo: 업로드한 비디오 파일 정보 저장
          await _repository.saveVideo(
            VideoModel(
                title: "video title",
                description: "video description",
                fileUrl: await task.ref.getDownloadURL(),
                thumbnailUrl: "", // Cloud Function -> 썸네일 URL을 제공할 것
                creator: userProfile.name,
                creatorUid: user.uid,
                likes: 0,
                comments: 0,
                createdAt: DateTime.now().millisecondsSinceEpoch),
          );
          context.pushReplacement("/home");
        }
      });
    }
  }
}

final uploadVideoProvider = AsyncNotifierProvider<UploadVideoViewModel, void>(
  () => UploadVideoViewModel(),
);
