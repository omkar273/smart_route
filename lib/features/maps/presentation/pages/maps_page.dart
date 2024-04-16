import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import 'package:smart_route/core/utils/show_snackbar.dart';
import 'package:smart_route/features/maps/presentation/cubit/maps_cubit.dart';
import 'package:smart_route/features/maps/presentation/widgets/search_tab.dart';

class MapNavigation extends StatefulWidget {
  static const routeName = 'MapNavigationPage';
  static const routePath = '/MapNavigationPage';
  const MapNavigation({super.key});

  @override
  State<MapNavigation> createState() => _MapNavigationState();
}

class _MapNavigationState extends State<MapNavigation> with OSMMixinObserver {
  final MapController controller = MapController.withUserPosition(
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

  void addRoad({PickedData? source, PickedData? destination}) async {
    try {
      if (source == null || destination == null) {
        return;
      }
      showTextSnackBar('starting road');
      await controller.drawRoad(
          GeoPoint(
              latitude: source.latLong.latitude,
              longitude: source.latLong.longitude),
          GeoPoint(
              latitude: destination.latLong.latitude,
              longitude: destination.latLong.longitude),
          roadType: RoadType.bike,
          roadOption: const RoadOption(
            roadColor: Colors.amber,
            roadBorderWidth: 12,
            roadWidth: 12,
          ));
      await controller.rotateMapCamera(20);
    } catch (e) {
      showTextSnackBar(e.toString());
    }
  }

  void addMarker(
      {PickedData? data, required String markerId, Icon? icon}) async {
    try {
      if (data == null) {
        return;
      }
      // print('inside add marker on location ${data.address}');
      await controller.setMarkerOfStaticPoint(
        id: markerId,
        markerIcon: MarkerIcon(
          icon: icon ??
              const Icon(
                Icons.location_on,
                color: Colors.red,
                size: 48,
              ),
        ),
      );

      await controller.setStaticPosition(
        [
          GeoPoint(
              latitude: data.latLong.latitude,
              longitude: data.latLong.longitude),
        ],
        markerId,
      );

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
      // addMarker();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: BlocBuilder<MapsCubit, MapsState>(
        builder: (context, state) {
          return ElevatedButton(
            onPressed: () {
              controller.rotateMapCamera(50);
              if (state.status == LocationPickedState.bothPicked) {
                controller.goToLocation(
                  GeoPoint(
                    latitude: state.source!.latLong.latitude,
                    longitude: state.source!.latLong.longitude,
                  ),
                );
              }
            },
            child: const Icon(Icons.turn_sharp_right),
          );
        },
      ),
      backgroundColor: Colors.amber,
      body: Row(
        children: [
          Expanded(
            flex: 70,
            child: Stack(
              children: [
                BlocListener<MapsCubit, MapsState>(
                  listener: (context, state) {
                    addMarker(
                        data: state.destination!,
                        markerId: 'destination destination');
                    addMarker(
                        data: state.source!, markerId: 'source destination');
                    addRoad(
                        source: state.source, destination: state.destination);
                  },
                  child: Container(),
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
                OSMFlutter(
                  onMapIsReady: (isReady) {
                    // addMarker(controller);
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
