import 'package:hive/hive.dart';
import 'package:pricecalc/features/price_list/price_list.dart';

part 'calc_item.g.dart';

/// Объект, описывающий предмет подсчёта с его ценой **[price]** и количеством для подсчёта **[quantity]**
@HiveType(typeId: 2)
class CalcItem {
  CalcItem({
    required this.uuid,
    required this.price,
    required this.quantity,
    required this.createdAt,
  });

  /// Уникальный идентификатор предмета подсчёта
  @HiveField(0)
  final String uuid;

  /// Цена предмета
  @HiveField(1)
  final Price price;

  /// Количество для подсчёта
  @HiveField(2)
  final double quantity;

  /// Дата создания
  @HiveField(3)
  final DateTime createdAt;

  CalcItem copyWith({Price? price, double? quantity}) => CalcItem(
    uuid: uuid,
    price: price ?? this.price,
    quantity: quantity ?? this.quantity,
    createdAt: createdAt,
  );

  double totalPrice() {
    double minPrice = price.defaultPrice;

    for (var condition in price.conditions) {
      if ((condition.from <= quantity) &&
          (condition.to > quantity) &&
          (condition.price < minPrice)) {
        minPrice = condition.price;
      }
    }

    var totalPrice = minPrice * quantity;

    return totalPrice;
  }
}
