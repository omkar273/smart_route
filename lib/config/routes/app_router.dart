import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_route/core/pages/landing_page.dart';
import 'package:smart_route/features/audio_handler/presentation/pages/song_info_page.dart';
import 'package:smart_route/features/audio_handler/presentation/pages/songs_page.dart';
import 'package:smart_route/features/maps/presentation/pages/maps_page.dart';

class Approuter {
  static final Approuter _instance = Approuter.init();

  static final instance = _instance;
  static late final GoRouter router;

  static final GlobalKey<NavigatorState> parentNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> mapTabNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> songTabNavigatorKey =
      GlobalKey<NavigatorState>();

  Approuter.init() {
    final List<RouteBase> routes = [
      StatefulShellRoute.indexedStack(
        parentNavigatorKey: parentNavigatorKey,
        branches: [
          StatefulShellBranch(
            navigatorKey: mapTabNavigatorKey,
            routes: [
              GoRoute(
                path: MapNavigation.routePath,
                name: MapNavigation.routeName,
                pageBuilder: (context, state) =>
                    getPage(child: const MapNavigation(), state: state),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: songTabNavigatorKey,
            initialLocation: SongsPage.routePath,
            routes: [
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
            ],
          ),
        ],
        pageBuilder: (context, state, navigationShell) => getPage(
            child: LandingPage(navigationShell: navigationShell), state: state),
      ),
    ];
    router = GoRouter(
      initialLocation: MapNavigation.routePath,
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
