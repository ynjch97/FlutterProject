// ignore_for_file: slash_for_doc_comments

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/users/models/user_profile_model.dart';
import 'package:tiktok_clone/features/users/repos/user_repository.dart';

/**1. 계정이 없는 유저의 계정을 생성
 * 2. 계정이 있어서 이미 로그인한 상태 -> 유저 프로필 가져오기
 */
class UsersViewModel extends AsyncNotifier<UserProfileModel> {
  late final UserRepository _userRepo;

  @override
  FutureOr<UserProfileModel> build() {
    _userRepo = ref.read(userRepo);
    return UserProfileModel.empty();
  }

  // AuthenticationRepository > 계정 생성 > UserCredential 타입으로 받음
  Future<void> createProfile(UserCredential credential) async {
    if (credential.user == null) {
      throw Exception("Account not created");
    }

    state = const AsyncValue.loading(); // 로딩 중

    final profile = UserProfileModel(
      uid: credential.user!.uid, // 회원가입 uid 를 키값으로 사용 예정
      email: credential.user!.email ?? "temp@gmail.com",
      name: credential.user!.displayName ?? "temp",
      bio: "undefined",
      link: "undefined",
    );

    await _userRepo.createProfile(profile); // 회원가입 정보 insert
    state = AsyncValue.data(profile); // state 에 profile 담기
  }
}

final userProvider = AsyncNotifierProvider<UsersViewModel, UserProfileModel>(
  () => UsersViewModel(),
);
