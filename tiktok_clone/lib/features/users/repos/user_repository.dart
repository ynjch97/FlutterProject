import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_profile_model.dart';

class UserRepository {
  // 데이터베이스 접근하기
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // create profile
  Future<void> createProfile(UserProfileModel user) async {
    // set(Map<String, dynamic> data, [SetOptions? options])
    await _db.collection("users").doc(user.uid).set(user.toJson());
  }
  // get profile
  // update profile
}

final userRepo = Provider((ref) => UserRepository());
