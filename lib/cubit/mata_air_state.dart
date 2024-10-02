part of 'mata_air_cubit.dart';

@immutable
abstract class MataAirState {}

class MataAirInitial extends MataAirState {}

class MataAirLoading extends MataAirState {}

class MataAirLoaded extends MataAirState {
  final List<MataAir> mataAirList;

  MataAirLoaded(this.mataAirList);
}

class MataAirError extends MataAirState {
  final String message;

  MataAirError(this.message);
}