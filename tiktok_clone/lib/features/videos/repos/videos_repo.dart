import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/videos/models/video_model.dart';

class VideosRepository {
  final FirebaseStorage _storage = FirebaseStorage.instance; // 데이터스토리지 접근하기
  final FirebaseFirestore _db = FirebaseFirestore.instance; // 데이터베이스 접근하기

  // Video File 업로드
  UploadTask uploadVideoFile(File video, String uid) {
    // 1970년부터 지난 밀리초 숫자로 영상 파일명 지정
    final fileRef = _storage.ref().child(
        "/videos/$uid/${DateTime.now().millisecondsSinceEpoch.toString()}");
    return fileRef.putFile(video);
  }

  // Video Document 생성
  Future<void> saveVideo(VideoModel data) async {
    await _db.collection("videos").add(data.toJson());
  }
}

final videosRepo = Provider((ref) => VideosRepository());
