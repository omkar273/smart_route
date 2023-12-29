import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_route/core/utils/spacing.dart';
import 'package:smart_route/features/audio_handler/presentation/cubit/music_handler_cubit.dart';

class SongInfoPage extends StatefulWidget {
  static const routeName = "SongInfoPage";
  static const routePath = "/SongInfoPage";
  const SongInfoPage({super.key});

  @override
  State<SongInfoPage> createState() => _SongInfoPageState();
}

class _SongInfoPageState extends State<SongInfoPage>
    with TickerProviderStateMixin {
  late bool isPlaying;
  Duration _duration = const Duration();
  Duration _position = const Duration();

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    isPlaying = true;

    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 10));
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<MusicHandlerCubit, MusicState>(
        builder: (context, state) {
          if (state is MusicSongsState) {
            state.audioPlayer.durationStream.listen((duration) {
              setState(() {
                _duration = duration!;
              });
            });

            state.audioPlayer.positionStream.listen((position) {
              setState(() {
                _position = position;
              });
            });

            final song = state.songList.elementAt(state.currentPlayingIndex);
            return SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: double.maxFinite,
                child: Column(
                  children: [
                    Vspace(10),
                    RotationTransition(
                      turns: _animation,
                      child: const CircleAvatar(
                        radius: 120,
                        child: Icon(Icons.music_note, size: 100),
                      ),
                    ),
                    Vspace(25),
                    Text(
                      song.title,
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      song.artist ?? "",
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Vspace(20),
                    Row(
                      children: [
                        Text(_position.toString().split(".")[0]),
                        Expanded(
                          child: Slider(
                            min: const Duration(microseconds: 0)
                                .inSeconds
                                .toDouble(),
                            value: _position.inMicroseconds.toDouble(),
                            max: _duration.inMicroseconds.toDouble(),
                            onChanged: (microSeconds) {
                              state.seek(microSeconds.toInt());
                            },
                          ),
                        ),
                        Text(_duration.toString().split(".")[0]),
                      ],
                    ),
                    Vspace(25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed: () {
                            context
                                .read<MusicHandlerCubit>()
                                .seekToPrevious(state);
                          },
                          icon: const Icon(Icons.skip_previous, size: 40),
                        ),
                        IconButton(
                          onPressed: () {
                            if (state.isPlaying) {
                              _animationController.reset();
                              state.stopAudio();
                            } else {
                              _animationController.repeat();
                              state.playAudio();
                            }
                            setState(() {
                              isPlaying = state.isPlaying;
                            });
                          },
                          icon: isPlaying
                              ? const Icon(Icons.pause, size: 40)
                              : const Icon(Icons.play_arrow_sharp, size: 40),
                        ),
                        IconButton(
                          onPressed: () {
                            context.read<MusicHandlerCubit>().seekToNext(state);
                          },
                          icon: const Icon(Icons.skip_next, size: 40),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          }
          return const CircularProgressIndicator.adaptive();
        },
      ),
    );
  }
}
