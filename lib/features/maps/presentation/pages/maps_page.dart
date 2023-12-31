import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_route/features/maps/presentation/widgets/map_page_song_tile.dart';

class MapNavigation extends StatefulWidget {
  static const routeName = "MapNavigation";
  static const routePath = "/MapNavigation";
  const MapNavigation({super.key});

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  State<MapNavigation> createState() => _MapNavigationState();
}

class _MapNavigationState extends State<MapNavigation> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: MapNavigation._kGooglePlex,
            ),
          ),
          MapPageSongTile(),
        ],
      ),
    );
  }
}
