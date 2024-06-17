// ignore_for_file: slash_for_doc_comments

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/users/models/user_profile_model.dart';
import 'package:tiktok_clone/features/users/repos/user_repository.dart';

/**1. 계정이 없는 유저의 계정을 생성
 * 2. 계정이 있어서 이미 로그인한 상태 -> 유저 프로필 가져오기 (initialize 필요)
 */
class UsersViewModel extends AsyncNotifier<UserProfileModel> {
  late final UserRepository _userRepo;
  late final AuthenticationRepository _authRepo;

  @override
  FutureOr<UserProfileModel> build() async {
    _userRepo = ref.read(userRepo);
    _authRepo = ref.read(authRepo);

    // 이미 로그인 된 데이터가 있다면 정보 가져오기
    if (_authRepo.isLoggedIn) {
      final profile = await _userRepo.findProfile(_authRepo.user!.uid);
      if (profile != null) {
        return UserProfileModel.fromJson(profile);
      }
    }
    return UserProfileModel.empty();
  }

  // AuthenticationRepository > 계정 생성 > UserCredential 타입으로 받음
  Future<void> createProfile(
      UserCredential credential, Map<dynamic, dynamic> form) async {
    if (credential.user == null) {
      throw Exception("Account not created");
    }

    state = const AsyncValue.loading(); // 로딩 중

    final profile = UserProfileModel(
      uid: credential.user!.uid, // 회원가입 uid 를 키값으로 사용 예정
      email: credential.user!.email ?? "temp@gmail.com",
      name: credential.user!.displayName ?? form["name"] ?? "temp",
      bio: "undefined",
      link: "undefined",
      birthday: form["birthday"] ?? "undefined",
    );

    await _userRepo.createProfile(profile); // 회원가입 정보 insert
    state = AsyncValue.data(profile); // state 에 profile 담기
  }
}

final userProvider = AsyncNotifierProvider<UsersViewModel, UserProfileModel>(
  () => UsersViewModel(),
);
