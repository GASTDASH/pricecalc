import 'package:hive_flutter/hive_flutter.dart';
import 'package:pricecalc/features/history/history.dart';
import 'package:pricecalc/features/home/home.dart';
import 'package:uuid/uuid.dart';

class HistoryRepository {
  final Box<HistoryItem> _box = Hive.box<HistoryItem>('history');

  Future<List<HistoryItem>> getHistoryItems() async =>
      _box.values.toList()..sort((a, b) => a.savedAt.compareTo(b.savedAt));

  Future<void> addHistoryItem({
    required List<CalcItem> calcItems,
    required double totalAmount,
  }) async {
    final now = DateTime.now();
    final uuid = Uuid().v4();

    _box.put(
      uuid,
      HistoryItem(
        uuid: uuid,
        calcItems: calcItems,
        savedAt: now,
        totalAmount: totalAmount,
      ),
    );
  }

  Future<void> removeHistoryItem(String uuid) async => _box.delete(uuid);
}
