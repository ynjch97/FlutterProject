import 'package:shared_preferences/shared_preferences.dart';

class PlaybackConfigRepository {
  static const String _muted = "muted";
  static const String _autoplay = "autoplay";

  final SharedPreferences _preferences;

  PlaybackConfigRepository(this._preferences);

  // 음소거 관련 데이터 디스크에 저장
  Future<void> setMuted(bool value) async {
    _preferences.setBool(_muted, value);
  }

  // 자동재생 관련 데이터 디스크에 저장
  Future<void> setAutoplay(bool value) async {
    _preferences.setBool(_autoplay, value);
  }

  // 음소거 관련 데이터 디스크에서 읽기
  bool isMuted() {
    return _preferences.getBool(_muted) ?? false;
  }

  // 자동재생 관련 데이터 디스크에서 읽기
  bool isAutoplay() {
    return _preferences.getBool(_autoplay) ?? false;
  }
}
