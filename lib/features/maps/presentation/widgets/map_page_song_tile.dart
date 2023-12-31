import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:smart_route/core/utils/spacing.dart';
import 'package:smart_route/features/audio_handler/presentation/cubit/music_handler_cubit.dart';

class MapPageSongTile extends StatefulWidget {
  const MapPageSongTile({super.key});

  @override
  State<MapPageSongTile> createState() => MapPageSongTileState();
}

class MapPageSongTileState extends State<MapPageSongTile>
    with TickerProviderStateMixin {
  bool isPlaying = false;
  Duration _duration = const Duration();
  Duration _position = const Duration();
  late StreamSubscription<Duration?> _durationStream;
  late StreamSubscription<Duration> _positionStream;
  late StreamSubscription<PlayerState> _playerStateStream;

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
  }

  @override
  void dispose() {
    _animationController.stop();
    _animationController.dispose();
    _durationStream.cancel();
    _positionStream.cancel();
    _playerStateStream.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MusicHandlerCubit, MusicState>(
      builder: (context, state) {
        if (state is MusicSongsState) {
          _durationStream = state.audioPlayer.durationStream.listen((duration) {
            setState(() {
              _duration = duration!;
            });
          });

          _positionStream = state.audioPlayer.positionStream.listen((position) {
            setState(() {
              _position = position;
            });
          });

          _playerStateStream =
              state.audioPlayer.playerStateStream.listen((state) {
            setState(() {
              isPlaying = state.playing;
            });
          });

          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RotationTransition(
                turns: _animation,
                child: const CircleAvatar(
                  radius: 30,
                  child: Icon(Icons.music_note, size: 40),
                ),
              ),
              Hspace(40),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: Column(
                  children: [
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            context
                                .read<MusicHandlerCubit>()
                                .seekToPrevious(state);
                          },
                          icon: const Icon(Icons.skip_previous, size: 30),
                        ),
                        IconButton(
                          onPressed: () {
                            if (isPlaying) {
                              _animationController.reset();
                              state.stopAudio();
                            } else {
                              _animationController.repeat();
                              state.playAudio();
                            }
                          },
                          icon: isPlaying
                              ? const Icon(Icons.pause, size: 30)
                              : const Icon(Icons.play_arrow_sharp, size: 30),
                        ),
                        IconButton(
                          onPressed: () {
                            context.read<MusicHandlerCubit>().seekToNext(state);
                          },
                          icon: const Icon(Icons.skip_next, size: 30),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
}
