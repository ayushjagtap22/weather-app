import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather/data/data/repository/remote_data_repository.dart';
import 'package:weather/data/models/one_call_model.dart';
import 'package:weather/data/models/weather_response_model.dart';

part 'current_weather_event.dart';
part 'current_weather_state.dart';

class CurrentWeatherBloc
    extends Bloc<CurrentWeatherEvent, CurrentWeatherState> {
  final RemoteDataRepository repository;
  CurrentWeatherBloc({required this.repository})
      : super(CurrentWeatherLoadingState()) {
    on<CurrentWeatherEvent>(getCurrentWeather);
  }

  Future<void> getCurrentWeather(
      CurrentWeatherEvent event, Emitter<CurrentWeatherState> emit) async {
    if (event is CurrentWeatherRequestedEvent) {
      final data = await repository.getAllWeatherData(
        event.latitude.toDouble(),
        event.longitude.toDouble(),
      );
      emit(
        CurrentWeatherReceivedState(currentWeather: data),
      );
    }
  }
}
