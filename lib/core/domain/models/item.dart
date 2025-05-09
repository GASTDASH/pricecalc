import 'package:hive/hive.dart';
import 'package:pricecalc/core/core.dart';

part 'item.g.dart';

/// Объект, описывающий предмет подсчёта. Подсчёт идёт по цене по умолчанию **[defaultPrice]** и цене, описанной в условиях **[conditions]**
@HiveType(typeId: 0)
class Item {
  Item({
    this.name,
    this.defaultPrice = 0,
    this.units,
    this.conditions = const [],
  });

  /// Название товара (предмета подсчёта)
  @HiveField(0)
  final String? name;

  /// Цена по умолчанию, используемая для подсчёта (по умолчанию 0.0)
  @HiveField(1)
  final double defaultPrice;

  /// Отображаемые единицы измерения
  @HiveField(2)
  final String? units;

  /// Список условий расценки
  @HiveField(3)
  final List<Condition> conditions;
}
