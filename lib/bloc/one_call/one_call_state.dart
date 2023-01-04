part of 'one_call_bloc.dart';

abstract class OneCallState extends Equatable {
  const OneCallState();
  
  @override
  List<Object> get props => [];
}

class OneCallInitial extends OneCallState {}
