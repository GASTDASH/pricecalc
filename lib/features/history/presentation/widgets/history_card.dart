import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pricecalc/features/history/history.dart';
import 'package:pricecalc/utils/utils.dart';

class HistoryCard extends StatelessWidget {
  const HistoryCard({super.key, required this.historyItem});

  final HistoryItem historyItem;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      borderRadius: BorderRadius.circular(12),
      elevation: 2,
      child: Ink(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            Column(
              spacing: 8,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: "Чек от ${historyItem.savedAt.toRusDate()} ",
                    style: theme.textTheme.headlineSmall,
                    children: [
                      TextSpan(
                        text:
                            historyItem.savedAt
                                .toString()
                                .split(' ')[1]
                                .split('.')[0],
                        style: theme.textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
                for (var calcItem in historyItem.calcItems)
                  Text(
                    "${calcItem.price.name ?? "Без названия"} (${calcItem.quantity} ${calcItem.price.units ?? "шт."}) - ${calcItem.price.defaultPrice % 1 == 0 ? calcItem.price.defaultPrice.truncate() : calcItem.price.defaultPrice} ₽",
                  ),
                SizedBox(height: 6),
                Text(
                  "Итого: ${historyItem.totalAmount % 1 == 0 ? historyItem.totalAmount.truncate() : historyItem.totalAmount} ₽",
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                  onPressed: () {
                    BlocProvider.of<HistoryCubit>(
                      context,
                    ).removeHistoryItem(uuid: historyItem.uuid);
                  },
                  icon: Icon(Icons.delete),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
