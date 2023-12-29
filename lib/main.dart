import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio_background/just_audio_background.dart';

import 'config/routes/app_router.dart';
import 'core/get_it/service_locator.dart';
import 'features/audio_handler/presentation/cubit/music_handler_cubit.dart';

void main() async {
  Approuter.instance;
  await serviceLocatorInit();
  await JustAudioBackground.init(
    notificationColor: Colors.red,
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  runApp(const MyApp());
}

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MusicHandlerCubit(),
      child: MaterialApp.router(
        title: 'Smart Route',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
          useMaterial3: true,
        ),
        scaffoldMessengerKey: scaffoldMessengerKey,
        routerConfig: Approuter.router,
      ),
    );
  }
}
