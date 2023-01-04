part of 'current_weather_bloc.dart';

abstract class CurrentWeatherState extends Equatable {
  const CurrentWeatherState();

  @override
  List<Object> get props => [];
}

class CurrentWeatherLoadingState extends CurrentWeatherState {}

class CurrentWeatherReceivedState extends CurrentWeatherState {
  final OneCallModel currentWeather;

  const CurrentWeatherReceivedState({required this.currentWeather});

  @override
  List<Object> get props => [currentWeather];
}

class CurrentWeatherErrorState extends CurrentWeatherState {}
