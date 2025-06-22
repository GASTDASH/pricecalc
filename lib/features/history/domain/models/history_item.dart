import 'package:hive/hive.dart';
import 'package:pricecalc/features/home/home.dart';

part 'history_item.g.dart';

@HiveType(typeId: 4)
class HistoryItem {
  HistoryItem({
    required this.uuid,
    required this.calcItems,
    required this.savedAt,
    required this.totalAmount,
  });

  @HiveField(0)
  final String uuid;

  @HiveField(1)
  final List<CalcItem> calcItems;

  @HiveField(2)
  final DateTime savedAt;

  @HiveField(3)
  final double totalAmount;
}
