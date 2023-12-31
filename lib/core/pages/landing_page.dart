import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_route/config/routes/app_router.dart';
import 'package:smart_route/features/audio_handler/presentation/pages/song_info_page.dart';
import 'package:smart_route/features/audio_handler/presentation/pages/songs_page.dart';
import 'package:smart_route/features/maps/presentation/pages/maps_page.dart';
import 'package:smart_route/main.dart';

// ignore: must_be_immutable
class LandingPage extends StatelessWidget {
  static const routeName = "LandingPage";
  static const routePath = "/LandingPage";
  StatefulNavigationShell navigationShell;
  LandingPage({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: appPrimaryColor,
        height: double.infinity,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      Approuter.router.goNamed(MapNavigation.routeName);
                    },
                    icon: const Icon(Icons.home),
                    iconSize: 36,
                    color: Colors.white,
                  ),
                  IconButton(
                    onPressed: () {
                      Approuter.router.goNamed(SongsPage.routeName);
                    },
                    icon: const Icon(Icons.music_note),
                    iconSize: 36,
                    color: Colors.white,
                  ),
                  IconButton(
                    onPressed: () {
                      Approuter.router.goNamed(SongInfoPage.routeName);
                    },
                    icon: const Icon(Icons.play_arrow_rounded),
                    iconSize: 36,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            Expanded(
              child: navigationShell,
            )
          ],
        ),
      ),
    );
  }
}
