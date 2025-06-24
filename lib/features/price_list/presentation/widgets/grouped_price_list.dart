import 'package:flutter/material.dart';
import 'package:grouped_list/sliver_grouped_list.dart';
import 'package:pricecalc/features/group/group.dart';
import 'package:pricecalc/features/price_list/price_list.dart';

class GroupedPriceList extends StatelessWidget {
  const GroupedPriceList({
    super.key,
    required this.prices,
    required this.itemBuilder,
    this.padding = EdgeInsets.zero,
    this.groups,
  });

  final List<Price> prices;
  final List<Group>? groups;
  final Widget Function(BuildContext context, Price price) itemBuilder;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    bool hasNoGroup = false;

    List<Group> groupsWithoutNoPrices = [];
    if (groups != null) {
      for (var gr in groups!) {
        if (prices.indexWhere((p) => p.groupUuid == gr.uuid) != -1) {
          groupsWithoutNoPrices.add(gr);
        }
        if (prices.indexWhere((p) => p.groupUuid == null) != -1) {
          hasNoGroup = true;
        }
      }
    }

    List<Price> sortedPrices = [];
    sortedPrices = prices;
    sortedPrices.sort(
      (a, b) => (a.groupUuid ?? "0").compareTo(b.groupUuid ?? "0"),
    );

    return SliverPadding(
      padding: padding,
      sliver: SliverGroupedListView(
        separator: SizedBox(height: 24),
        elements: sortedPrices,
        groupBy: (price) => price.groupUuid ?? "0",
        itemBuilder: itemBuilder,
        itemComparator:
            (price1, price2) =>
                (price1.groupUuid ?? "0").compareTo(price2.groupUuid ?? "0"),
        groupComparator: (groupUuid1, groupUuid2) {
          if (groupUuid1 == "0" || groupUuid2 == "0") {
            return -1;
          }

          final group1 = (groupsWithoutNoPrices.firstWhere(
            (g) => g.uuid == groupUuid1,
          ));
          final group2 = (groupsWithoutNoPrices.firstWhere(
            (g) => g.uuid == groupUuid2,
          ));

          return (group1.name ?? "").compareTo(group2.name ?? "");
        },
        groupSeparatorBuilder: (groupUuid) {
          if (groupUuid == "0") hasNoGroup = true;

          final group = groupsWithoutNoPrices.firstWhere(
            (group) => group.uuid == groupUuid,
            orElse: () => Group(uuid: "0"),
          );

          return Padding(
            padding: EdgeInsets.only(
              top:
                  (groupUuid == "0" ||
                          (groupUuid == groupsWithoutNoPrices.first.uuid &&
                              !hasNoGroup))
                      ? 0
                      : 32,
              bottom: 8,
            ),
            child: Text(
              groupUuid == "0"
                  ? "Без группы"
                  : (group.name == null || group.name! == "")
                  ? "Без названия"
                  : group.name!,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
      ),
    );
  }
}
