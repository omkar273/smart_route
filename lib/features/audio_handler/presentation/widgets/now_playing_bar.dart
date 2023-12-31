// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: file_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:smart_route/config/routes/app_router.dart';
import 'package:smart_route/features/audio_handler/presentation/cubit/music_handler_cubit.dart';
import 'package:smart_route/features/audio_handler/presentation/pages/song_info_page.dart';
import 'package:smart_route/main.dart';

class NowPlayingBar extends StatefulWidget {
  const NowPlayingBar({super.key});

  @override
  State<NowPlayingBar> createState() => _NowPlayingBarState();
}

class _NowPlayingBarState extends State<NowPlayingBar>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool isPlaying = false;
  late StreamSubscription<PlayerState> _playerStateStream;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn);
  }

  @override
  void dispose() {
    _animationController.stop();
    _animationController.dispose();
    _playerStateStream.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MusicHandlerCubit, MusicState>(
      builder: (context, state) {
        if (state is MusicSongsState) {
          _playerStateStream =
              state.audioPlayer.playerStateStream.listen((state) {
            setState(() {
              isPlaying = state.playing;
            });
          });

          final SongModel song =
              state.songList.elementAt(state.currentPlayingIndex);
          return Container(
            padding: const EdgeInsets.all(15),
            width: MediaQuery.of(context).size.width - 100,
            decoration: BoxDecoration(
              color: appPrimaryColor,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(50),
            ),
            child: ListTile(
              minVerticalPadding: 15,
              leading: RotationTransition(
                turns: _animation,
                child: QueryArtworkWidget(
                  id: song.id,
                  type: ArtworkType.AUDIO,
                  nullArtworkWidget: const CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.music_note, size: 35),
                  ),
                ),
              ),
              style: ListTileStyle.drawer,
              title: InkWell(
                child: Text('${song.title.substring(0, 20)}...',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    )),
                onTap: () {
                  Approuter.router.pushNamed(SongInfoPage.routeName);
                },
              ),
              trailing: IconButton(
                icon: isPlaying
                    ? const Icon(
                        Icons.pause,
                        size: 40,
                        color: Colors.white,
                      )
                    : const Icon(
                        Icons.play_arrow,
                        size: 40,
                        color: Colors.white,
                      ),
                onPressed: () async {
                  if (state.isPlaying) {
                    state.audioPlayer.pause();
                    setState(() {
                      _animationController.reset();
                    });
                  } else {
                    setState(() {
                      _animationController.repeat();
                    });
                    state.audioPlayer.play();
                  }
                },
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
