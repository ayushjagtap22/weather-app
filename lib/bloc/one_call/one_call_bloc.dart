import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'one_call_event.dart';
part 'one_call_state.dart';

class OneCallBloc extends Bloc<OneCallEvent, OneCallState> {
  OneCallBloc() : super(OneCallInitial()) {
    on<OneCallEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
