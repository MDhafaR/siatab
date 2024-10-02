part of 'sumur_cubit.dart';

@immutable
abstract class SumurState {}

class SumurInitial extends SumurState {}

class SumurLoading extends SumurState {}

class SumurLoaded extends SumurState {
  final List<Sumur> sumurList;

  SumurLoaded(this.sumurList);
}

class SumurError extends SumurState {
  final String message;

  SumurError(this.message);
}