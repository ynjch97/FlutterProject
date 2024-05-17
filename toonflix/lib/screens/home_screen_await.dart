import 'package:flutter/material.dart';
import 'package:toonflix/models/webtoon_model.dart';
import 'package:toonflix/services/api_service.dart';

// StatefulWidget 으로 API 통신하기
class HomeScreenStateful extends StatefulWidget {
  const HomeScreenStateful({super.key});

  @override
  State<HomeScreenStateful> createState() => _HomeScreenStatefulState();
}

class _HomeScreenStatefulState extends State<HomeScreenStateful> {
  List<WebtoonModel> webtoons = [];
  bool isLoading = true;

  void waitForWebtoons() async {
    webtoons = await ApiService.getTodaysToons();
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    waitForWebtoons();
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold : screen 을 위한 기본적인 레이아웃, 설정을 제공
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF03C75A),
        foregroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        shadowColor: Colors.black,
        elevation: 2, // 음영을 주기 위해 surfaceTintColor, shadowColor 와 함께 사용
        centerTitle: true,
        title: const Text(
          'Today Webtoon',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
