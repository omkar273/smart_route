// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:smart_route/core/utils/show_snackbar.dart';
import 'package:smart_route/features/audio_handler/presentation/cubit/music_handler_cubit.dart';

import '../widgets/now_playing_bar.dart';

class SongsPage extends StatelessWidget {
  static const routeName = "HomePage";
  static const routePath = "/HomePage";
  const SongsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text("Music Player"),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
            ),
          ],
        ),
        primary: true,
        floatingActionButton: const NowPlayingBar(),
        body: BlocBuilder<MusicHandlerCubit, MusicState>(
          builder: (context, state) {
            if (state is MusicLoadingState) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }
            if (state is MusicNoPermissionState) {
              return centerText("Please grant permission");
            }

            if (state is MusicNoSongsState) {
              return centerText("NO songs available");
            }

            if (state is MusicErrorState) {
              const errorMsg = "Some error occurred please restart the app";
              WidgetsBinding.instance.addPostFrameCallback((_) {
                showTextSnackBar(errorMsg);
              });
              return centerText(errorMsg);
            }

            if (state is MusicSongsState) {
              return buildSongList(state);
            }
            return Container();
          },
        ));
  }
}

Widget buildSongList(MusicSongsState state) => ListView.separated(
      itemBuilder: (context, index) => ListTile(
        leading: QueryArtworkWidget(
          id: state.songList.elementAt(index).id,
          type: ArtworkType.AUDIO,
          nullArtworkWidget: const Icon(Icons.music_note),
        ),
        title: Text(state.songList.elementAt(index).title),
        subtitle: Text(state.songList.elementAt(index).artist ?? ""),
        trailing: const Icon(Icons.more_vert),
        onTap: () {
          state.audioPlayer.play();
          context.read<MusicHandlerCubit>().setAudioSource(state, index);
        },
      ),
      separatorBuilder: (context, index) => const Divider(),
      itemCount: state.songList.length,
    );

Widget centerText(String text) => Center(child: Text(text));
