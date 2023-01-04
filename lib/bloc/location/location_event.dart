part of 'location_bloc.dart';

@immutable
abstract class LocationEvent {}

class LocationServiceEnabledEvent extends LocationEvent {}

class LocationEnableEvent extends LocationEvent {}

class LocationRequestedEvent extends LocationEvent {}
