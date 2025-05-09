import 'package:hive/hive.dart';
import 'package:pricecalc/features/price_list/price_list.dart';

part 'price.g.dart';

/// Объект, описывающий предмет подсчёта. Подсчёт идёт по цене по умолчанию **[defaultPrice]** и цене, описанной в условиях **[conditions]**
@HiveType(typeId: 0)
class Price {
  Price({
    required this.uuid,
    this.name,
    this.defaultPrice = 0,
    this.units,
    this.conditions = const [],
    required this.createdAt,
  });

  /// Уникальный ID цены
  @HiveField(0)
  final String uuid;

  /// Название цены (предмета подсчёта)
  @HiveField(1)
  final String? name;

  /// Цена по умолчанию, используемая для подсчёта (по умолчанию 0.0)
  @HiveField(2)
  final double defaultPrice;

  /// Отображаемые единицы измерения
  @HiveField(3)
  final String? units;

  /// Список условий расценки
  @HiveField(4)
  final List<Condition> conditions;

  /// Дата создания цены
  @HiveField(5)
  final DateTime createdAt;

  Price copyWith({
    String? name,
    double? defaultPrice,
    String? units,
    List<Condition>? conditions,
  }) => Price(
    uuid: uuid,
    name: name ?? this.name,
    defaultPrice: defaultPrice ?? this.defaultPrice,
    units: units ?? this.units,
    conditions: conditions ?? this.conditions,
    createdAt: createdAt,
  );
}
