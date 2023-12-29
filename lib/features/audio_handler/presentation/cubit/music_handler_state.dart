// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

part of 'music_handler_cubit.dart';

abstract class MusicState extends Equatable {
  @override
  List<Object> get props => [];
}

final class MusicLoadingState extends MusicState {}

final class MusicNoPermissionState extends MusicState {}

final class MusicNoSongsState extends MusicState {}

final class MusicErrorState extends MusicState {}

class MusicSongsState extends MusicState {
  final List<SongModel> songList;
  final AudioPlayer audioPlayer;
  int currentPlayingIndex;
  MusicSongsState({
    required this.songList,
    required this.audioPlayer,
    this.currentPlayingIndex = 0,
  }) {
    try {
      final playList = ConcatenatingAudioSource(
          useLazyPreparation: true,
          shuffleOrder: DefaultShuffleOrder(),
          children: List.generate(songList.length, (index) {
            final song = songList.elementAt(index);
            return AudioSource.uri(Uri.parse(song.uri!),
                tag: MediaItem(
                  id: index.toString(),
                  title: song.title,
                  album: song.album,
                ));
          }));

      audioPlayer.setAudioSource(
        playList,
        initialIndex: currentPlayingIndex,
        initialPosition: Duration.zero,
      );
    } catch (e) {
      showTextSnackBar(e.toString());
    }
  }

  MusicSongsState copyWith({
    List<SongModel>? songList,
    AudioPlayer? audioPlayer,
    int? currentPlayingIndex,
  }) {
    return MusicSongsState(
      songList: songList ?? this.songList,
      audioPlayer: audioPlayer ?? this.audioPlayer,
      currentPlayingIndex: currentPlayingIndex ?? this.currentPlayingIndex,
    );
  }

  @override
  bool get stringify => true;

  void playAudio() {
    try {
      audioPlayer.play();
    } catch (e) {
      showTextSnackBar(e.toString());
    }
  }

  @override
  List<Object> get props => [songList, audioPlayer, currentPlayingIndex];
}
