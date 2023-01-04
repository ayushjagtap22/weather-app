import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart' as l;
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationInitial()) {
    on<LocationEvent>(getLocation);
  }

  Future<void> getLocation(
      LocationEvent event, Emitter<LocationState> emit) async {
    LocationPermission? permission;
    bool? isServiceEnabled;
    final l.Location location = l.Location();
    if (event is LocationRequestedEvent) {
      if (await location.serviceEnabled() == false) {
        emit(LocationRequestedState());
      }
      return emit(
        LocationFetchState(
          position: await _determinePosition(),
        ),
      );
    } else {
      emit(LocationDeniedState());
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    l.Location location = l.Location();

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await location.requestService();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}
