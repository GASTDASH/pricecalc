import 'package:hive/hive.dart';

part 'condition.g.dart';

/// Объект условия, по начальному **[from]** и конечному **[to]** количеству предмета которого присваивается определённая стоимость **[price]**
@HiveType(typeId: 1)
class Condition extends HiveObject {
  Condition({required this.uuid, this.from, this.to, this.price})
  // : assert(
  //     (from ?? 0) < (to ?? 1),
  //     "Начальное количество не может быть больше конечного",
  //   )
  ;

  /// Уникальный идентификатор
  @HiveField(0)
  final String uuid;

  /// Начальное количество предмета для новой стоимости
  @HiveField(1)
  final double? from;

  /// Конечное количество предмета для новой стоимости
  @HiveField(2)
  final double? to;

  /// Новая стоимость для условия
  @HiveField(3)
  final double? price;

  Condition copyWith({double? from, double? to, double? price}) {
    return Condition(
      uuid: uuid,
      from: from ?? this.from,
      to: to ?? this.to,
      price: price ?? this.price,
    );
  }
}
