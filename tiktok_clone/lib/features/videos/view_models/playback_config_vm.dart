// ignore_for_file: slash_for_doc_comments

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/videos/models/playback_config_model.dart';
import 'package:tiktok_clone/features/videos/repos/playback_config_repo.dart';

/**22.1 Notifier 안에 expose 할 데이터를 넣음 (화면이 listen 하기를 원하는 데이터)
 * - Notifier 는 State 를 가짐 => Notifier 내 어디서든 데이터에 접근 가능
 * - State : 사용자에게 노출시키고 싶은 데이터
 * - 모델 객체 접근 방식 => _model.muted 대신, state.muted (데이터가 변경되지 않음)
 * - 모델 객체 데이터 변경 => State 를 대체해야 함
 *   - state = PlaybackConfigModel(muted: value, autoplay: state.autoplay);
 */
class PlaybackConfigViewModel extends Notifier<PlaybackConfigModel> {
  final PlaybackConfigRepository _repository;

  PlaybackConfigViewModel(this._repository);

  @override
  PlaybackConfigModel build() {
    // PlaybackConfigViewModel build => 화면이 갖게 되는 초기 데이터를 return
    return PlaybackConfigModel(
      muted: _repository.isMuted(),
      autoplay: _repository.isAutoplay(),
    );
  }

  void setMuted(bool value) {
    _repository.setMuted(value);
    // 상태 변경하면 모든 listener 들이 자동으로 통지 받음
    state = PlaybackConfigModel(
      muted: value,
      autoplay: state.autoplay,
    );
  }

  void setAutoplay(bool value) {
    _repository.setAutoplay(value);
    state = PlaybackConfigModel(
      muted: state.muted,
      autoplay: value,
    );
  }
}

// NotifierProvider<데이터 변화를 통지, Provider 가 expose 할 데이터>
// PlaybackConfigViewModel(repository) 가 필요한데 여기에 repository 를 쓸 수 없어서 에러를 내고, main.dart 에서 받아옴
final playbackConfigProvider =
    NotifierProvider<PlaybackConfigViewModel, PlaybackConfigModel>(
  () => throw UnimplementedError(),
);
