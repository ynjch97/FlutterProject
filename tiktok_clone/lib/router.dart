// ignore_for_file: slash_for_doc_comments

import 'package:go_router/go_router.dart';

import 'features/videos/video_recording_screen.dart';

// #19 VIDEO RECORDING => 기존 개발 내용 지우고 새롭게 구성 (백업 : router_backup.dart)
final router = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const VideoRecordingScreen(),
    ),
  ],
);
