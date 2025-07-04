import 'package:hive/hive.dart';

part 'group.g.dart';

/// Объект группы, для группировки цен через **Price.groupUuid**
@HiveType(typeId: 3)
class Group {
  Group({required this.uuid, this.name});

  /// Уникальный идентификатор группы
  @HiveField(0)
  final String uuid;

  /// Название группы
  @HiveField(1)
  final String? name; // Возможно лучше заменить на not nullable и по умолчанию сделать "Без названия", но тогда не забудь о Hive

  Group copyWith({String? name}) => Group(uuid: uuid, name: name ?? this.name);
}
