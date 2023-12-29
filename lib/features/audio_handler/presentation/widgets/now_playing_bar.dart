// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:smart_route/config/routes/app_router.dart';
import 'package:smart_route/features/audio_handler/presentation/cubit/music_handler_cubit.dart';
import 'package:smart_route/features/audio_handler/presentation/pages/song_info_page.dart';

class NowPlayingBar extends StatefulWidget {
  const NowPlayingBar({super.key});

  @override
  State<NowPlayingBar> createState() => _NowPlayingBarState();
}

class _NowPlayingBarState extends State<NowPlayingBar>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

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
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MusicHandlerCubit, MusicState>(
      builder: (context, state) {
        if (state is MusicSongsState) {
          final SongModel song =
              state.songList.elementAt(state.currentPlayingIndex);
          return Container(
            width: MediaQuery.of(context).size.width - 30,
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              minVerticalPadding: 15,
              leading: RotationTransition(
                turns: _animation,
                child: QueryArtworkWidget(
                  id: song.id,
                  type: ArtworkType.AUDIO,
                  nullArtworkWidget: const CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.music_note),
                  ),
                ),
              ),
              style: ListTileStyle.drawer,
              title: InkWell(
                child: Text('${song.title.substring(0, 20)}...'),
                onTap: () {
                  Approuter.router.pushNamed(SongInfoPage.routeName);
                },
              ),
              trailing: IconButton(
                icon: state.audioPlayer.playing
                    ? const Icon(Icons.pause)
                    : const Icon(Icons.play_arrow),
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
