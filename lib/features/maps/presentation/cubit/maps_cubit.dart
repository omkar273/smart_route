import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

part 'maps_state.dart';

class MapsCubit extends Cubit<MapsState> {
  MapsCubit() : super(const MapsState());

  void setSource(PickedData data) {
    if (state.destination == null) {
      emit(state.copyWith(
          source: data, status: LocationPickedState.sourcePicked));
      return;
    }
    emit(state.copyWith(status: LocationPickedState.bothPicked, source: data));

    // print(state);
  }

  void setDestination(PickedData data) {
    if (state.source == null) {
      emit(state.copyWith(
          destination: data, status: LocationPickedState.destinationPicked));
      return;
    }

    emit(state.copyWith(
        status: LocationPickedState.bothPicked, destination: data));
  }
}
