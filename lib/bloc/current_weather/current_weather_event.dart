part of 'current_weather_bloc.dart';

abstract class CurrentWeatherEvent extends Equatable {
  const CurrentWeatherEvent();

  @override
  List<Object> get props => [];
}

class CurrentWeatherRequestedEvent extends CurrentWeatherEvent {
  final double longitude;
  final double latitude;

  const CurrentWeatherRequestedEvent({
    required this.longitude,
    required this.latitude,
  });

  @override
  List<Object> get props => [longitude, latitude];
}
