import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:siatab/models/mata_air.dart';
import 'package:siatab/services/local_database.dart';

part 'mata_air_state.dart';

class MataAirCubit extends Cubit<MataAirState> {
  final LocalDatabase _localDatabase;

  MataAirCubit(this._localDatabase) : super(MataAirInitial());

  Future<void> loadMataAir() async {
    try {
      emit(MataAirLoading());
      final mataAirList = await _localDatabase.getMataAir();
      emit(MataAirLoaded(mataAirList));
    } catch (e) {
      emit(MataAirError('Failed to load mata air data: ${e.toString()}'));
    }
  }

  Future<void> addMataAir(MataAir mataAir) async {
    try {
      await _localDatabase.insertMataAir(mataAir);
      await loadMataAir(); // Reload the list after adding
    } catch (e) {
      emit(MataAirError('Failed to add mata air: ${e.toString()}'));
    }
  }

  Future<void> updateMataAir(MataAir mataAir) async {
    try {
      await _localDatabase.updateMataAir(mataAir);
      await loadMataAir(); // Reload the list after updating
    } catch (e) {
      emit(MataAirError('Failed to update mata air: ${e.toString()}'));
    }
  }

  Future<void> deleteMataAir(int id) async {
    try {
      await _localDatabase.deleteMataAir(id);
      await loadMataAir(); // Reload the list after deleting
    } catch (e) {
      emit(MataAirError('Failed to delete mata air: ${e.toString()}'));
    }
  }
}