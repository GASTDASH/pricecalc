import 'package:hive_flutter/hive_flutter.dart';
import 'package:pricecalc/features/price_list/price_list.dart';
import 'package:uuid/uuid.dart';

class PriceRepository {
  Box<Price> box = Hive.box<Price>('prices');

  Future<List<Price>> getPrices() async =>
      box.values.toList()..sort((a, b) => a.createdAt.compareTo(b.createdAt));

  Future<void> addPrice() async {
    var uuid = Uuid().v4();
    box.put(uuid, Price(uuid: uuid, createdAt: DateTime.now()));
  }

  Future<void> removePrice(String uuid) async => box.delete(uuid);

  Future<void> updatePrice(Price price) async => box.put(price.uuid, price);
}
