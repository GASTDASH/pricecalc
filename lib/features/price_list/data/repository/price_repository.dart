import 'package:hive_flutter/hive_flutter.dart';
import 'package:pricecalc/features/price_list/price_list.dart';
import 'package:uuid/uuid.dart';

class PriceRepository {
  final Box<Price> _box = Hive.box<Price>('prices');

  Future<List<Price>> getPrices() async =>
      _box.values.toList()..sort((a, b) => a.createdAt.compareTo(b.createdAt));

  Future<void> addPrice({Price? price}) async {
    var uuid = Uuid().v4();
    _box.put(
      uuid,
      price == null
          ? Price(uuid: uuid, createdAt: DateTime.now())
          : price.copyWith(uuid: uuid, createdAt: DateTime.now()),
    );
  }

  Future<void> removePrice(String uuid) async => _box.delete(uuid);

  Future<void> updatePrice(Price price) async => _box.put(price.uuid, price);
}
