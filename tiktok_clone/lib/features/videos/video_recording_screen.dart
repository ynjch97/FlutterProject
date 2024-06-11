// ignore_for_file: slash_for_doc_comments

import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/routes.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/videos/video_preview_screen.dart';

class VideoRecordingScreen extends StatefulWidget {
  static const routeURL = Routes.videoRecordingScreen;
  static const routeName = RoutesName.videoRecordingScreen;

  const VideoRecordingScreen({super.key});

  @override
  State<VideoRecordingScreen> createState() => _VideoRecordingScreenState();
}

// AnimationController 가 2개 이상이면 SingleTickerProviderStateMixin 사용 X
class _VideoRecordingScreenState extends State<VideoRecordingScreen>
    with TickerProviderStateMixin {
  bool _hasPermission = false;

  bool _isSelfieMode = false;
  List<dynamic> _cameraMode = [];

  late FlashMode _flashMode;

  // 디버그 모드인지 확인 && iOS 에서 구동 중인지 확인
  late final bool _noCamera = kDebugMode && Platform.isIOS;

  late CameraController _cameraController;

  late final AnimationController _buttonAnimationController =
      AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 200),
  );

  late final Animation<double> _buttonAnimation =
      Tween(begin: 1.0, end: 1.3).animate(_buttonAnimationController);

  late final AnimationController _progressAnimationController =
      AnimationController(
    vsync: this,
    duration: const Duration(seconds: 3), // 10초 녹화
    lowerBound: 0.0, // 최솟값
    upperBound: 1.0, // 최댓값
  );

  @override
  void initState() {
    super.initState();
    if (!_noCamera) {
      initPermissions();
    } else {
      _hasPermission = true;
    }

    // lowerBound~upperBound 까지 매 순간마다 setState
    _progressAnimationController.addListener(() {
      setState(() {});
    });

    // Status 에 대한 리스너 추가 => 10초 경과 후 녹화 종료
    _progressAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _stopRecording();
      }
    });
  }

  @override
  void dispose() {
    _buttonAnimationController.dispose();
    _progressAnimationController.dispose();
    if (!_noCamera) _cameraController.dispose(); // 초기화 된 경우에만 dispose() 되어야 함

    super.dispose();
  }

  /*
  20.5 먼저 수행함
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_noCamera) return;
  }
  */

  Future<void> initCamera() async {
    /**사용 가능한 카메라 리스트 확인
     * - 보통 전면/후면 총 2개
     * - [CameraDescription(Camera 0, CameraLensDirection.front, 270), CameraDescription(Camera 1, CameraLensDirection.back, 90)]
     * - [CameraDescription(Camera 0, CameraLensDirection.back, 90), CameraDescription(Camera 1, CameraLensDirection.front, 270)] ... 
     * - sort => CameraLensDirection.front 일 때 0으로 세팅
     */
    final cameras = await availableCameras();
    if (cameras.isEmpty) {
      return;
    }

    // 0이면 front, 1이면 back 이 되도록 => 실제 핸드폰은 CameraDescription 이 4개 => 1 : 3 분기 처리
    cameras
        .sort((a, b) => a.lensDirection == CameraLensDirection.front ? 0 : 1);
    _cameraMode = [0, (cameras.length == 2 ? 1 : 3)];

    _cameraController = CameraController(
      // CameraDescription
      cameras[_isSelfieMode ? _cameraMode[0] : _cameraMode[1]],
      ResolutionPreset.ultraHigh,
      // 공식 문서상, 애뮬레이터에서 enableAudio true 상태로 녹화하면, camera > MediaRecorder 가 제대로 작동하지 않는다고 함
      // enableAudio: false,
    );

    await _cameraController.initialize();

    // for iOS only (영상과 소리 싱크 문제 해결)
    await _cameraController.prepareForVideoRecording();

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

  Future<void> _setFlashMode(FlashMode newFlashMode) async {
    await _cameraController.setFlashMode(newFlashMode);
    _flashMode = newFlashMode;
    setState(() {});
  }

  Future<void> _startRecording(TapDownDetails _) async {
    // 녹화 중이 아니라면 녹화 시작
    if (_cameraController.value.isRecordingVideo) return;
    await _cameraController.startVideoRecording();

    _buttonAnimationController.forward();
    _progressAnimationController.forward();
  }

  Future<void> _stopRecording() async {
    // 리스너에서도 쓰기 위해 TapDownDetails 파라미터를 제거함
    _buttonAnimationController.reverse();
    _progressAnimationController.reset();

    // 녹화 중이라면 녹화 종료 후 XFile 을 리턴
    if (!_cameraController.value.isRecordingVideo) return;
    final video = await _cameraController.stopVideoRecording();
    // await _cameraController.takePicture(); 로도 비디오 파일 얻을 수 있음

    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPreviewScreen(
          video: video,
          isPicked: false,
        ),
      ),
    );
  }

  Future<void> _onPickVideoPressed() async {
    final video = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (video == null) return;

    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPreviewScreen(
          video: video,
          isPicked: true, // 저장 버튼 숨기기
        ),
      ),
    );
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
                    if (!_noCamera && _cameraController.value.isInitialized)
                      CameraPreview(_cameraController),
                    const Positioned(
                        top: Sizes.size20,
                        left: Sizes.size20,
                        child: CloseButton(
                          color: Colors.white,
                        )),
                    if (!_noCamera)
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
                            FlashButton(
                              onPressedFunction: () =>
                                  _setFlashMode(FlashMode.off),
                              isSelected: _flashMode == FlashMode.off,
                              icon: Icons.flash_off_rounded,
                            ),
                            Gaps.v10,
                            FlashButton(
                              onPressedFunction: () =>
                                  _setFlashMode(FlashMode.always),
                              isSelected: _flashMode == FlashMode.always,
                              icon: Icons.flash_on_rounded,
                            ),
                            Gaps.v10,
                            FlashButton(
                              onPressedFunction: () =>
                                  _setFlashMode(FlashMode.auto),
                              isSelected: _flashMode == FlashMode.auto,
                              icon: Icons.flash_auto_rounded,
                            ),
                            Gaps.v10,
                            FlashButton(
                              // 손전등 모드
                              onPressedFunction: () =>
                                  _setFlashMode(FlashMode.torch),
                              isSelected: _flashMode == FlashMode.torch,
                              icon: Icons.flashlight_on_rounded,
                            ),
                          ],
                        ),
                      ),
                    Positioned(
                      bottom: Sizes.size40,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          // 변형 가능한 빈 공간을 제공
                          const Spacer(),
                          GestureDetector(
                            onTapDown: _startRecording,
                            onTapUp: (details) => _stopRecording(),
                            child: ScaleTransition(
                              scale: _buttonAnimation,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  const SizedBox(
                                    width: Sizes.size94,
                                    height: Sizes.size94,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: Sizes.size6,
                                      value: 1.0,
                                    ),
                                  ),
                                  SizedBox(
                                    width: Sizes.size94,
                                    height: Sizes.size94,
                                    child: CircularProgressIndicator(
                                      color:
                                          Colors.red.shade400.withOpacity(0.8),
                                      strokeWidth: Sizes.size6,
                                      value: _progressAnimationController.value,
                                    ),
                                  ),
                                  Container(
                                    width: Sizes.size80,
                                    height: Sizes.size80,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.red.shade400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              child: IconButton(
                                onPressed: _onPickVideoPressed,
                                icon: const FaIcon(
                                  FontAwesomeIcons.image,
                                  color: Colors.white,
                                ),
                              ),
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

class FlashButton extends StatelessWidget {
  final void Function() onPressedFunction;
  final bool isSelected;
  final IconData icon;

  const FlashButton({
    super.key,
    required this.onPressedFunction,
    required this.isSelected,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: isSelected ? Colors.amber.shade200 : Colors.white,
      onPressed: onPressedFunction,
      icon: Icon(icon),
    );
  }
}
