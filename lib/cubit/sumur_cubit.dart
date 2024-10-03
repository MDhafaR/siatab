import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:siatab/models/sumur.dart';
import 'package:siatab/services/local_database.dart';

part 'sumur_state.dart';

class SumurCubit extends Cubit<SumurState> {
  final LocalDatabase _localDatabase;

  SumurCubit(this._localDatabase) : super(SumurInitial());

  Future<void> loadSumur() async {
    try {
      emit(SumurLoading());
      print("cek");
      final sumurList = await _localDatabase.getSumur();
      print("ini po sumur load $sumurList");
      emit(SumurLoaded(sumurList));
    } catch (e) {
      print("ini po error load sumur $e");
      emit(SumurError('Failed to load sumur data: ${e.toString()}'));
    }
  }

  Future<void> addSumur(Sumur sumur) async {
    try {
      await _localDatabase.insertSumur(sumur);
      await loadSumur();
    } catch (e) {
      print("ini po error add sumur $e");
      emit(SumurError('Failed to add sumur: ${e.toString()}'));
    }
  }

  Future<void> updateSumur(Sumur sumur) async {
    try {
      await _localDatabase.updateSumur(sumur);
      await loadSumur(); // Reload the list after updating
    } catch (e) {
      emit(SumurError('Failed to update sumur: ${e.toString()}'));
    }
  }

  Future<void> deleteSumur(int id) async {
    try {
      await _localDatabase.deleteSumur(id);
      await loadSumur(); // Reload the list after deleting
    } catch (e) {
      emit(SumurError('Failed to delete sumur: ${e.toString()}'));
    }
  }
}
