import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pricecalc/features/history/history.dart';
import 'package:pricecalc/features/home/home.dart';

part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  final HistoryRepository _historyRepository;

  HistoryCubit(this._historyRepository) : super(HistoryLoaded());

  void loadHistory() async {
    try {
      emit(HistoryLoading());

      final historyItems = await _historyRepository.getHistoryItems();

      emit(HistoryLoaded(items: historyItems));
    } catch (e) {
      emit(HistoryError(error: e));
    }
  }

  void addHistoryItem({
    required List<CalcItem> calcItems,
    required double totalAmount,
  }) async {
    try {
      emit(HistoryLoading());

      await _historyRepository.addHistoryItem(
        calcItems: calcItems,
        totalAmount: totalAmount,
      );
      final historyItems = await _historyRepository.getHistoryItems();

      emit(HistoryLoaded(items: historyItems));
    } catch (e) {
      emit(HistoryError(error: e));
    }
  }

  void removeHistoryItem({required String uuid}) async {
    try {
      emit(HistoryLoading());

      await _historyRepository.removeHistoryItem(uuid);
      final historyItems = await _historyRepository.getHistoryItems();

      emit(HistoryLoaded(items: historyItems));
    } catch (e) {
      emit(HistoryError(error: e));
    }
  }
}
