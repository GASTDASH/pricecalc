import 'package:hive_flutter/hive_flutter.dart';
import 'package:pricecalc/features/home/home.dart';
import 'package:pricecalc/features/price_list/price_list.dart';
import 'package:uuid/uuid.dart';

class CalcItemRepository {
  final Box<CalcItem> _box = Hive.box<CalcItem>('calc_items');

  Future<List<CalcItem>> getCalcItems() async =>
      _box.values.toList()..sort((a, b) => a.createdAt.compareTo(b.createdAt));

  Future<void> addCalcItem(Price price) async {
    for (var calcItem in _box.values) {
      if (calcItem.price.uuid == price.uuid) {
        _box.put(
          calcItem.uuid,
          CalcItem(
            uuid: calcItem.uuid,
            price: calcItem.price,
            quantity: calcItem.quantity + 1,
            createdAt: calcItem.createdAt,
          ),
        );
        return;
      }
    }

    var uuid = Uuid().v4();
    _box.put(
      uuid,
      CalcItem(
        uuid: uuid,
        price: price,
        quantity: 1,
        createdAt: DateTime.now(),
      ),
    );
  }

  Future<void> removeCalcItem(String uuid) async => _box.delete(uuid);

  Future<void> updateCalcItem(CalcItem calcItem) async =>
      _box.put(calcItem.uuid, calcItem);
}
