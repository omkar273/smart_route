import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_route/features/audio_handler/presentation/pages/song_info_page.dart';
import 'package:smart_route/features/audio_handler/presentation/pages/songs_page.dart';

class Approuter {
  static final Approuter _instance = Approuter.init();

  static final instance = _instance;
  static late final GoRouter router;

  static final GlobalKey<NavigatorState> parentNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> homeTabNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> searchTabNavigatorKey =
      GlobalKey<NavigatorState>();

  Approuter.init() {
    final List<RouteBase> routes = [
      GoRoute(
        path: SongsPage.routePath,
        name: SongsPage.routeName,
        pageBuilder: (context, state) =>
            getPage(child: const SongsPage(), state: state),
      ),
      GoRoute(
        path: SongInfoPage.routePath,
        name: SongInfoPage.routeName,
        pageBuilder: (context, state) =>
            getPage(child: const SongInfoPage(), state: state),
      ),
    ];
    router = GoRouter(
      initialLocation: SongsPage.routePath,
      navigatorKey: parentNavigatorKey,
      routes: routes,
    );
  }
  static Page getPage({
    required Widget child,
    required GoRouterState state,
  }) {
    return NoTransitionPage(
      key: state.pageKey,
      child: child,
    );
  }
}
