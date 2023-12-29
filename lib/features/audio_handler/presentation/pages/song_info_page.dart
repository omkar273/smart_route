import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_route/features/audio_handler/presentation/cubit/music_handler_cubit.dart';

class SongInfoPage extends StatelessWidget {
  static const routeName = "SongInfoPage";
  static const routePath = "/SongInfoPage";
  const SongInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<MusicHandlerCubit, MusicState>(
        builder: (context, state) {
          return Container();
        },
      ),
    );
  }
}
