// ignore_for_file: slash_for_doc_comments

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/onboarding/interests_screen.dart';
import 'package:tiktok_clone/features/users/view_models/users_view_model.dart';
import 'package:tiktok_clone/utils.dart';

/**계정 생성 시 로딩 화면 보여주고, 계정 생성을 트리거
 * StateProvider => 바깥에서 수정할 수 있는 value 를 expose 하게 함
 * 인증 저장소에 대한 접근 권한 필요 => AuthenticationRepository authRepo
 */
class SignUpViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _authRepo;

  @override
  FutureOr<void> build() {
    _authRepo = ref.read(authRepo);
  }

  Future<void> signUp(BuildContext context) async {
    state = const AsyncValue.loading(); // 로딩 중
    final form = ref.read(signUpForm); // 회원가입 폼
    final users = ref.read(userProvider.notifier); // users(사용자) View Model

    // AsyncValue.guard() : 코드 실행 후, 에러 발생 시 그 에러를 state 에 리턴 / 정상 실행 시 결과값을 state 에 리턴
    state = await AsyncValue.guard(() async {
      final userCredential = await _authRepo.emailSignUp(
        form["email"],
        form["password"],
      );

      // 에러 없으면 이미 실행되었다는 뜻이므로 검사 생략
      users.createProfile(userCredential);
    });
    // state = const AsyncValue.data(null); // 로딩 상태 제거
    if (state.hasError) {
      showFirebaseErrorSnack(context, state.error);
    } else {
      context.goNamed(InterestsScreen.routeName);
    }
  }
}

final signUpForm = StateProvider((ref) => {});

final signUpProvider = AsyncNotifierProvider<SignUpViewModel, void>(
  () => SignUpViewModel(),
);
