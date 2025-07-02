import 'package:flutter/material.dart';
import 'package:pricecalc/features/group/group.dart';
import 'package:pricecalc/features/price_list/price_list.dart';

// TODO: Сделать объединение двух группированных списков (Home и PriceList)
class GroupedPriceList extends StatelessWidget {
  const GroupedPriceList({
    super.key,
    this.controller,
    this.padding = EdgeInsets.zero,
    required this.prices,
    this.groups,
  });

  final ScrollController? controller;
  final EdgeInsetsGeometry padding;
  final List<Price> prices;
  final List<Group>? groups;

  @override
  Widget build(BuildContext context) {
    final List<String> groupUuids = [];
    for (var price in prices) {
      if (groupUuids.indexWhere((uuid) => uuid == (price.groupUuid ?? "0")) ==
          -1) {
        groupUuids.add(price.groupUuid ?? "0");
      }
    }

    if (groups != null && groups!.isNotEmpty) {
      Map<String, String> groupsMap = {};
      for (var group in groups!) {
        groupsMap.addAll({group.uuid: group.name ?? "Без названия"});
      }

      groupUuids.sort(
        (uuid1, uuid2) =>
            (groupsMap[uuid1] ?? "0").compareTo(groupsMap[uuid2] ?? "0"),
      );
    }

    return SliverPadding(
      padding: padding,
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          if (groupUuids.isNotEmpty)
            for (var groupUuid in groupUuids)
              PriceGroup(
                group: (groups ?? []).firstWhere(
                  (group) => group.uuid == groupUuid,
                  orElse: () => Group(uuid: "0"),
                ),
                prices:
                    prices
                        .where((price) => (price.groupUuid ?? "0") == groupUuid)
                        .toList(),
              ),
        ]),
      ),
    );
  }
}
