import 'package:flutter/material.dart';
import 'package:pricecalc/features/group/group.dart';
import 'package:pricecalc/features/home/home.dart';
import 'package:pricecalc/features/price_list/price_list.dart';

enum GroupedItemListType { wrap, list }

class GroupedItemList extends StatelessWidget {
  const GroupedItemList({
    super.key,
    required this.prices,
    this.controller,
    this.groups,
    this.type = GroupedItemListType.wrap,
  });

  final List<Price> prices;
  final ScrollController? controller;
  final List<Group>? groups;
  final GroupedItemListType type;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final List<String> groupUuids = [];
    for (var price in prices) {
      if (groupUuids.indexWhere((uuid) => uuid == (price.groupUuid ?? "0")) ==
          -1) {
        groupUuids.add(price.groupUuid ?? "0");
      }
    }

    return Expanded(
      child:
          type == GroupedItemListType.wrap
              ? SingleChildScrollView(
                controller: controller,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (groupUuids.isNotEmpty)
                      for (var groupUuid in groupUuids)
                        Builder(
                          builder: (context) {
                            final group = (groups ?? []).firstWhere(
                              (group) => group.uuid == groupUuid,
                              orElse: () => Group(uuid: "0"),
                            );

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: Column(
                                spacing: 8,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    groupUuid == "0"
                                        ? "Без группы"
                                        : (group.name == null ||
                                            group.name! == "")
                                        ? "Без названия"
                                        : group.name!,
                                    style: theme.textTheme.titleLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Wrap(
                                    runSpacing: 12,
                                    spacing: 12,
                                    children: [
                                      for (var price in prices.where(
                                        (price) =>
                                            (price.groupUuid ?? "0") ==
                                            group.uuid,
                                      ))
                                        ItemChip(
                                          price: price,
                                          onTap: () {
                                            Navigator.of(context).pop(price);
                                          },
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                  ],
                ),
              )
              : ListView(
                controller: controller,
                children: [
                  if (groupUuids.isNotEmpty)
                    for (var groupUuid in groupUuids)
                      Builder(
                        builder: (context) {
                          final group = (groups ?? []).firstWhere(
                            (group) => group.uuid == groupUuid,
                            orElse: () => Group(uuid: "0"),
                          );

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Column(
                              spacing: 8,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  groupUuid == "0"
                                      ? "Без группы"
                                      : (group.name == null ||
                                          group.name! == "")
                                      ? "Без названия"
                                      : group.name!,
                                  style: theme.textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Column(
                                  children: [
                                    for (var price in prices.where(
                                      (price) =>
                                          (price.groupUuid ?? "0") ==
                                          group.uuid,
                                    )) ...[
                                      ItemTile(
                                        price: price,
                                        onTap: () {
                                          Navigator.of(context).pop(price);
                                        },
                                      ),
                                      Divider(height: 0),
                                    ],
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                ],
              ),
    );
  }
}
