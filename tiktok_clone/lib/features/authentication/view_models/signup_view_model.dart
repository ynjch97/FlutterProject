// ignore_for_file: slash_for_doc_comments

import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';

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

  Future<void> signUp() async {
    state = const AsyncValue.loading(); // 로딩 중
    final form = ref.read(signUpForm);

    // AsyncValue.guard() : 코드 실행 후, 에러 발생 시 그 에러를 state 에 리턴 / 정상 실행 시 결과값을 state 에 리턴
    state = await AsyncValue.guard(
      () async => await _authRepo.signUp(
        form["email"],
        form["password"],
      ),
    );
    // state = const AsyncValue.data(null); // 로딩 상태 제거
  }
}

final signUpForm = StateProvider((ref) => {});

final signUpProvider = AsyncNotifierProvider<SignUpViewModel, void>(
  () => SignUpViewModel(),
);
