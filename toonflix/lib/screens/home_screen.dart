import 'package:flutter/material.dart';
import 'package:toonflix/models/webtoon_model.dart';
import 'package:toonflix/services/api_service.dart';

class HomeScreen extends StatelessWidget {
  // const HomeScreen({super.key});
  // 클래스 안에 Future 가 있기 때문에, const 는 제거해야 함
  HomeScreen({super.key});

  Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

  @override
  Widget build(BuildContext context) {
    // Scaffold : screen 을 위한 기본적인 레이아웃, 설정을 제공
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF00DC64),
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
      body: FutureBuilder(
        future: webtoons,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const Text('there is data');
          }
          return const Text('loading...');
        },
      ),
    );
  }
}
