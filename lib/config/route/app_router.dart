import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_route/core/pages/landing_page.dart';
import 'package:smart_route/features/music/presentation/pages/music_page.dart';
import 'package:smart_route/main.dart';

class Approuter {
  static final Approuter _instance = Approuter.init();

  static final instance = _instance;
  static late final GoRouter router;

  static final GlobalKey<NavigatorState> parentNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> musicTabNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> homeTabNavigatorKey =
      GlobalKey<NavigatorState>();

  Approuter.init() {
    final List<RouteBase> routes = <RouteBase>[
      // landing page with bottom bar
      StatefulShellRoute.indexedStack(
        parentNavigatorKey: parentNavigatorKey,
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            navigatorKey: homeTabNavigatorKey,
            routes: [
              GoRoute(
                path: MyHomePage.routePath,
                name: MyHomePage.routeName,
                pageBuilder: (context, state) => getPage(
                  child: const MyHomePage(),
                  state: state,
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: musicTabNavigatorKey,
            routes: [
              GoRoute(
                path: MusicPage.routePath,
                name: MusicPage.routeName,
                pageBuilder: (context, state) => getPage(
                  child: const MusicPage(),
                  state: state,
                ),
              ),
            ],
          ),
        ],
        pageBuilder: (context, state, navigationShell) => getPage(
            child: LandingPage(navigationShell: navigationShell), state: state),
      ),
    ];
    router = GoRouter(
      initialLocation: MyHomePage.routePath,
      navigatorKey: parentNavigatorKey,
      routes: routes,
    );
  }
  static Page getPage({
    required Widget child,
    required GoRouterState state,
  }) {
    return MaterialPage(
      key: state.pageKey,
      child: child,
    );
  }
}

extension GoRouterExtension on GoRouter {
  String get location {
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    final String location = matchList.uri.toString();
    return location;
  }

  Stream<String> get locationStream => Stream<String>.periodic(
        const Duration(seconds: 1),
        (computationCount) {
          return Approuter.router.location;
        },
      );
}
