// ignore_for_file: slash_for_doc_comments

/**17 NAVIGATOR DEEP DIVE
 * Route 변수 값을 각 .dart 페이지에 추가하지 않고, constants 로 관리
 */
class Routes {
  static const signUpScreen = "/";
  static const loginScreen = "/login";
  static const interestsScreen = "/tutorial";
  static const mainScreen = "/:tab(home|discover|inbox|profile)"; // 네 가지 값만 받음

  // Home
  static const videoTimelineScreen = "/home";

  // Inbox
  static const activityScreen = "/activity";
  static const chatsScreen = "/chats";
  static const chatDetailScreen = ":chatId"; // 자식 경로 /chats/:chatId

  // Post Video
  static const videoRecordingScreen = "/upload";

  static const usernameScreen = "username";
  static const emailScreen = "email";
  static const userProfileScreen = "/users/:username";
}

class RoutesName {
  static const signUpScreen = "signUpScreen";
  static const loginScreen = "loginScreen";
  static const interestsScreen = "interests";
  static const mainScreen = "mainNavigation";

  // Home
  static const videoTimelineScreen = "home";

  // Inbox
  static const activityScreen = "activity";
  static const chatsScreen = "chats";
  static const chatDetailScreen = "chatDetail";

  // Post Video
  static const videoRecordingScreen = "postVideo";

  static const usernameScreen = "usernameScreen";
  static const emailScreen = "emailScreen";
  static const userProfileScreen = "userProfileScreen";
}

class Tabs {
  // MainNavigationScreen 탭
  static const List<String> mainTabs = [
    "home",
    "discover",
    "video",
    "inbox",
    "profile",
  ];
}
