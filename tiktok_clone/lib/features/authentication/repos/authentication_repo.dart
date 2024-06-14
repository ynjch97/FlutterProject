// ignore_for_file: slash_for_doc_comments

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthenticationRepository {
  /**1. main.dart Firebase.initializeApp() 로 초기화 하고
   * 2. FirebaseAuth.instance 를 생성하면
   * => 바로 Firebase 와 소통할 수 있음
   */
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  bool get isLoggedIn => user != null;
  User? get user => _firebaseAuth.currentUser; // 로그인한 사용자는 Nullable

  Future<void> signUp(String email, String password) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}

final authRepo = Provider((ref) => AuthenticationRepository());
