import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smart_route/core/utils/permission_handler.dart';
import 'package:smart_route/core/utils/snackbar.dart';

part 'music_state.dart';

class MusicCubit extends Cubit<MusicState> {
  final OnAudioQuery onAudioQuery = OnAudioQuery();
  final AudioPlayer audioPlayer = AudioPlayer();
  MusicCubit() : super(MusicInitial()) {
    print('inside music cubit');
    getSongs();
  }

  void getSongs() async {
    try {
      final bool isPermissionGranted =
          (await requestPermission(Permission.storage) ||
              await requestPermission(Permission.audio));

      if (!isPermissionGranted) {
        emit(MusicNoPermissionState());
        return;
      }

      final List<SongModel> songsList = await onAudioQuery.querySongs(
        ignoreCase: true,
        orderType: OrderType.ASC_OR_SMALLER,
        uriType: UriType.EXTERNAL,
      );
      print(songsList);
    } catch (e) {
      showTextSnackBar(e.toString());
    }
  }
}
