// ignore_for_file: slash_for_doc_comments

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class VideoRecordingScreen extends StatefulWidget {
  const VideoRecordingScreen({super.key});

  @override
  State<VideoRecordingScreen> createState() => _VideoRecordingScreenState();
}

class _VideoRecordingScreenState extends State<VideoRecordingScreen> {
  bool _hasPermission = false;

  bool _isSelfieMode = false;
  List<dynamic> _cameraMode = [];

  late FlashMode _flashMode;

  late CameraController _cameraController;

  Future<void> initCamera() async {
    /**사용 가능한 카메라 리스트 확인
     * - 보통 전면/후면 총 2개
     * - [CameraDescription(Camera 0, CameraLensDirection.front, 270), CameraDescription(Camera 1, CameraLensDirection.back, 90)]
     * - [CameraDescription(Camera 0, CameraLensDirection.back, 90), CameraDescription(Camera 1, CameraLensDirection.front, 270)] ... 
     * - sort => CameraLensDirection.front 일 때 0으로 세팅
     */
    final cameras = await availableCameras();
    cameras
        .sort((a, b) => a.lensDirection == CameraLensDirection.front ? 0 : 1);

    // 0이면 front, 1이면 back 이 되도록 => 실제 핸드폰은 CameraDescription 이 4개 => 1 : 3 분기 처리
    _cameraMode = [0, (cameras.length == 2 ? 1 : 3)];

    if (cameras.isEmpty) {
      return;
    }

    _cameraController = CameraController(
      // CameraDescription
      cameras[_isSelfieMode ? _cameraMode[0] : _cameraMode[1]],
      ResolutionPreset.ultraHigh,
    );

    await _cameraController.initialize();

    // 핸드폰의 카메라가 가진 flashMode 값으로 초기화
    _flashMode = _cameraController.value.flashMode;
  }

  Future<void> initPermissions() async {
    final cameraPermission = await Permission.camera.request();
    final micPermission = await Permission.microphone.request();

    // isPermanentlyDenied : Don't ask me again (요청 거절 후에는 사용자가 설정에서 직접 활성화해야 함)
    final cameraDenied =
        cameraPermission.isDenied || cameraPermission.isPermanentlyDenied;
    final micDenied =
        micPermission.isDenied || micPermission.isPermanentlyDenied;

    if (!cameraDenied && !micDenied) {
      _hasPermission = true; // 권한이 존재한다는 의미
      await initCamera(); // 카메라 실행

      setState(() {});
    }
  }

  Future<void> _toggleSelfieMode() async {
    _isSelfieMode = !_isSelfieMode;
    await initCamera();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initPermissions();
  }

  Future<void> _setFlashMode(FlashMode newFlashMode) async {
    await _cameraController.setFlashMode(newFlashMode);
    _flashMode = newFlashMode;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: !_hasPermission || !_cameraController.value.isInitialized
              ? const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Initializing...", // 권한 요청 중
                      style: TextStyle(
                          color: Colors.white, fontSize: Sizes.size20),
                    ),
                    Gaps.v20,
                    CircularProgressIndicator.adaptive(),
                  ],
                )
              : Stack(
                  alignment: Alignment.center,
                  children: [
                    CameraPreview(_cameraController),
                    Positioned(
                      top: Sizes.size20,
                      right: Sizes.size20,
                      child: Column(
                        children: [
                          IconButton(
                            onPressed: _toggleSelfieMode,
                            color: Colors.white,
                            icon: const Icon(Icons.cameraswitch),
                          ),
                          Gaps.v10,
                          IconButton(
                            color: _flashMode == FlashMode.off
                                ? Colors.amber.shade200
                                : Colors.white,
                            onPressed: () => _setFlashMode(FlashMode.off),
                            icon: const Icon(
                              Icons.flash_off_rounded,
                            ),
                          ),
                          Gaps.v10,
                          IconButton(
                            color: _flashMode == FlashMode.always
                                ? Colors.amber.shade200
                                : Colors.white,
                            onPressed: () => _setFlashMode(FlashMode.always),
                            icon: const Icon(
                              Icons.flash_on_rounded,
                            ),
                          ),
                          Gaps.v10,
                          IconButton(
                            color: _flashMode == FlashMode.auto
                                ? Colors.amber.shade200
                                : Colors.white,
                            onPressed: () => _setFlashMode(FlashMode.auto),
                            icon: const Icon(
                              Icons.flash_auto_rounded,
                            ),
                          ),
                          Gaps.v10,
                          IconButton(
                            // 손전등 모드
                            color: _flashMode == FlashMode.torch
                                ? Colors.amber.shade200
                                : Colors.white,
                            onPressed: () => _setFlashMode(FlashMode.torch),
                            icon: const Icon(
                              Icons.flashlight_on_rounded,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
