part of 'location_bloc.dart';

@immutable
abstract class LocationState {}

class LocationInitial extends LocationState {}

class LocationRequestedState extends LocationState {}

class LocationGrantedState extends LocationState {}

class LocationDeniedState extends LocationState {}

class LocationDisabledState extends LocationState {}

class LocationFetchState extends LocationState {
  final Position position;

  LocationFetchState({
    required this.position,
  });
}
