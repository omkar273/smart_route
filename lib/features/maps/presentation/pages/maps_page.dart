import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:smart_route/core/utils/show_snackbar.dart';
import 'package:smart_route/features/maps/presentation/widgets/search_tab.dart';

class MapNavigation extends StatefulWidget {
  static const routeName = 'MapNavigationPage';
  static const routePath = '/MapNavigationPage';
  const MapNavigation({super.key});

  @override
  State<MapNavigation> createState() => _MapNavigationState();
}

class _MapNavigationState extends State<MapNavigation> with OSMMixinObserver {
  final controller = MapController.withUserPosition(
      trackUserLocation: const UserTrackingOption(
    enableTracking: true,
    unFollowUser: false,
  ));
  // MapController controller = MapController(
  //   initPosition: GeoPoint(latitude: 19.997454, longitude: 73.789803),
  // );

  @override
  void initState() {
    super.initState();
    controller.listenerMapSingleTapping.addListener(() {
      if (controller.listenerMapSingleTapping.value != null) {}
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void addMarker() async {
    try {
      // await controller.setMarkerOfStaticPoint(
      //   id: "current_location",
      //   markerIcon: const MarkerIcon(
      //     icon: Icon(
      //       Icons.person_pin_circle,
      //       size: 48,
      //     ),
      //   ),
      // );

      // await controller.setStaticPosition(
      //   [
      //     GeoPoint(latitude: 19.997454, longitude: 73.789803),
      //   ],
      //   'current_location',
      // );

      // await controller.drawRoad(
      //   GeoPoint(latitude: 19.997454, longitude: 73.789803),
      //   GeoPoint(latitude: 21.997454, longitude: 20.789803),
      // );
    } catch (e) {
      showTextSnackBar(e.toString());
    }
  }

  @override
  Future<void> mapIsReady(bool isReady) async {
    if (isReady) {
      addMarker();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ElevatedButton(
        onPressed: () {},
        child: const Icon(Icons.turn_sharp_right),
      ),
      backgroundColor: Colors.amber,
      body: Row(
        children: [
          Expanded(
            flex: 70,
            child: Stack(
              children: [
                Positioned(
                  bottom: 20,
                  left: 200,
                  width: double.maxFinite,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Start'),
                  ),
                ),
                OSMFlutter(
                  onMapIsReady: (isReady) {
                    addMarker();
                  },
                  onLocationChanged: (loacation) {},
                  onGeoPointClicked: (point) {},
                  controller: controller,
                  osmOption: OSMOption(
                    showZoomController: true,
                    showDefaultInfoWindow: true,
                    userTrackingOption: const UserTrackingOption(
                      enableTracking: true,
                      unFollowUser: false,
                    ),
                    zoomOption: const ZoomOption(
                      initZoom: 18,
                      minZoomLevel: 3,
                      maxZoomLevel: 19,
                      stepZoom: 1.0,
                    ),
                    userLocationMarker: UserLocationMaker(
                      personMarker: const MarkerIcon(
                        icon: Icon(
                          Icons.person_pin_circle,
                          color: Colors.purple,
                          size: 175,
                        ),
                      ),
                      directionArrowMarker: const MarkerIcon(
                        icon: Icon(
                          Icons.double_arrow,
                          size: 48,
                        ),
                      ),
                    ),
                    roadConfiguration: const RoadOption(
                      roadColor: Colors.yellowAccent,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 200,
                  width: double.maxFinite,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Start'),
                  ),
                ),
              ],
            ),
          ),

          // searchtab
          const Expanded(
            flex: 30,
            child: SearchTab(),
          )
        ],
      ),
    );
  }
}
