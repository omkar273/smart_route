import 'package:flutter/material.dart';
import 'package:smart_route/features/maps/presentation/widgets/map_page_song_tile.dart';

import '../widgets/search_tab.dart';

class MapNavigation extends StatefulWidget {
  static const routeName = "MapNavigation";
  static const routePath = "/MapNavigation";
  const MapNavigation({super.key});

  @override
  State<MapNavigation> createState() => _MapNavigationState();
}

class _MapNavigationState extends State<MapNavigation> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 15,
            child: Column(
              children: [
                
                MapPageSongTile(),
              ],
            ),
          ),
          Expanded(flex: 5, child: SearchTab()),
        ],
      ),
    );
  }
}
