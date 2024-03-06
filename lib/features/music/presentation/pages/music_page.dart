import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_route/features/music/presentation/cubit/music_cubit.dart';

class MusicPage extends StatefulWidget {
  static const routeName = 'MusicPage';
  static const routePath = '/MusicPage';
  const MusicPage({super.key});

  @override
  State<MusicPage> createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  @override
  Widget build(BuildContext context) {
    context.read<MusicCubit>().getSongs();
    return const Scaffold();
  }
}
