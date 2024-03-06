import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/utils/permission_handler.dart';
import '../../../../core/utils/show_snackbar.dart';

part 'music_handler_state.dart';

class MusicHandlerCubit extends Cubit<MusicState> {
  final OnAudioQuery onAudioQuery = OnAudioQuery();
  final AudioPlayer audioPlayer = AudioPlayer();

  MusicHandlerCubit() : super(MusicLoadingState()) {
    getSongs();
  }

  void getSongs() async {
    try {
      final isPermissionGranted = (await requestPermission(Permission.audio) ||
          await requestPermission(Permission.storage));
      if (!isPermissionGranted) {
        emit(MusicNoPermissionState());
        return;
      }

      final List<SongModel> songsList = await onAudioQuery.querySongs(
        ignoreCase: true,
        orderType: OrderType.ASC_OR_SMALLER,
        uriType: UriType.EXTERNAL,
      );
      if (songsList.isEmpty) {
        emit(MusicNoSongsState());
      }
      if (songsList.isNotEmpty) {
        emit(MusicSongsState(songList: songsList, audioPlayer: audioPlayer));
      }
    } catch (e) {
      // ignore: avoid_print
      print('error inside cubit $e');
      emit(MusicErrorState());
    }
  }

  void setAudioSource(MusicSongsState state, int index) {
    emit(state.copyWith(currentPlayingIndex: index));
  }

  void seekToNext(MusicSongsState state) {
    state.audioPlayer.seekToNext();
    emit(
      state.copyWith(
          currentPlayingIndex:
              (state.currentPlayingIndex + 1) % state.songList.length),
    );
  }

  void seekToPrevious(MusicSongsState state) {
    state.audioPlayer.seekToPrevious();
    emit(
      state.copyWith(
          currentPlayingIndex:
              (state.currentPlayingIndex - 1) % state.songList.length),
    );
  }
}
