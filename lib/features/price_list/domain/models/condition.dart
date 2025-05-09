import 'package:hive/hive.dart';

part 'condition.g.dart';

/// Объект условия, по начальному **[from]** и конечному **[to]** количеству предмета которого присваивается определённая стоимость **[price]**
@HiveType(typeId: 1)
class Condition extends HiveObject {
  Condition({required this.from, required this.to, required this.price})
    : assert(from < to, "Начальное количество не может быть больше конечного");

  /// Начальное количество предмета для новой стоимости
  @HiveField(0)
  final double from;

  /// Конечное количество предмета для новой стоимости
  @HiveField(1)
  final double to;

  /// Новая стоимость для условия
  @HiveField(2)
  final double price;
}
