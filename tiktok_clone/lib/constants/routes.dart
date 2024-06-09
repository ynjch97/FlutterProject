// ignore_for_file: slash_for_doc_comments

import 'package:tiktok_clone/features/onboarding/interests_screen.dart';

/**17 NAVIGATOR DEEP DIVE
 * Route 변수 값을 각 .dart 페이지에 추가하지 않고, constants 로 관리
 */
class Routes {
  static const signUpScreen = "/";
  static const interestsScreen = "/tutorial";

  static const usernameScreen = "username";
  static const emailScreen = "email";
  static const loginScreen = "/login";
  static const userProfileScreen = "/users/:username";
}

class RoutesName {
  static const signUpScreen = "signUpScreen";
  static const interestsScreen = "interests";

  static const usernameScreen = "usernameScreen";
  static const emailScreen = "emailScreen";
  static const loginScreen = "loginScreen";
  static const userProfileScreen = "userProfileScreen";
}
