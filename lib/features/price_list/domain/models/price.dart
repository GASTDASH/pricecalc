import 'package:hive/hive.dart';
import 'package:pricecalc/features/condition/condition.dart';

part 'price.g.dart';

/// Объект, описывающий цену предмета подсчёта. Подсчёт идёт по цене по умолчанию **[defaultPrice]** и цене, описанной в условиях **[conditions]**
@HiveType(typeId: 0)
class Price {
  Price({
    required this.uuid,
    this.name,
    this.defaultPrice = 0,
    this.units,
    this.conditions = const [],
    required this.createdAt,
    this.groupUuid,
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

  /// ID папки
  @HiveField(6)
  final String? groupUuid;

  Price copyWith({
    String? uuid,
    String? name,
    double? defaultPrice,
    String? units,
    List<Condition>? conditions,
    DateTime? createdAt,
    String? groupUuid,
  }) => Price(
    uuid: uuid ?? this.uuid,
    name: name ?? this.name,
    defaultPrice: defaultPrice ?? this.defaultPrice,
    units: units ?? this.units,
    conditions: conditions ?? this.conditions,
    createdAt: createdAt ?? this.createdAt,
    groupUuid: groupUuid ?? this.groupUuid,
  );
}
