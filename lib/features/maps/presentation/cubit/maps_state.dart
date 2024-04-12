// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'maps_cubit.dart';

enum LocationPickedState {
  initial,
  sourcePicked,
  destinationPicked,
  bothPicked
}

class MapsState extends Equatable {
  final PickedData? source;
  final PickedData? destination;
  final LocationPickedState status;
  const MapsState({
    this.source,
    this.destination,
    this.status = LocationPickedState.initial,
  });

  MapsState copyWith({
    final PickedData? source,
    final PickedData? destination,
    final LocationPickedState? status,
  }) {
    return MapsState(
      source: source ?? this.source,
      destination: destination ?? this.destination,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [status];

  @override
  bool get stringify => true;
}
