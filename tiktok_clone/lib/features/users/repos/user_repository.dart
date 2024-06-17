import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_profile_model.dart';

class UserRepository {
  // 데이터스토리지 접근하기
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // 데이터베이스 접근하기
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // create profile
  Future<void> createProfile(UserProfileModel user) async {
    // set(Map<String, dynamic> data, [SetOptions? options])
    await _db.collection("users").doc(user.uid).set(user.toJson());
  }

  // get profile
  Future<Map<String, dynamic>?> findProfile(String uid) async {
    final doc = await _db.collection("users").doc(uid).get();
    return doc.data();
  }

  Future<void> uploadAvatar(File file, String fileName) async {
    final fileRef = _storage.ref().child("avatar/$fileName");
    await fileRef.putFile(file);
  }

  // update profile
}

final userRepo = Provider((ref) => UserRepository());
