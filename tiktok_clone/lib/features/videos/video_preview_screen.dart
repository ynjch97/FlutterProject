import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:video_player/video_player.dart';

class VideoPreviewScreen extends StatefulWidget {
  final XFile video;

  const VideoPreviewScreen({
    super.key,
    required this.video,
  });

  @override
  State<VideoPreviewScreen> createState() => _VideoPreviewScreenState();
}

class _VideoPreviewScreenState extends State<VideoPreviewScreen> {
  bool _isSavedVideo = false;

  late final VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();
    _initVideo();
  }

  Future<void> _initVideo() async {
    _videoPlayerController =
        VideoPlayerController.file(File(widget.video.path));

    await _videoPlayerController.initialize();

    await _videoPlayerController.setLooping(true); // 반복 재생

    await _videoPlayerController.play();

    setState(() {});
  }

  Future<void> _saveToGallery() async {
    if (_isSavedVideo) return;

    // 파일 저장 전, 권한 요청이 수락되어야 함
    // Todo: .temp 파일로 저장되고 있어서 saveVideo 에 type 불일치 오류 발생
    await GallerySaver.saveVideo(
      widget.video.path,
      albumName: "TikTok Clone", // 저장할 앨범 위치
    );

    _isSavedVideo = true;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Preview Video"),
        actions: [
          IconButton(
            onPressed: _saveToGallery,
            icon: FaIcon(_isSavedVideo
                ? FontAwesomeIcons.check
                : FontAwesomeIcons.download),
          )
        ],
      ),
      body: _videoPlayerController.value.isInitialized
          ? VideoPlayer(_videoPlayerController)
          : null,
    );
  }
}
