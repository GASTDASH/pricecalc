import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pricecalc/core/core.dart';
import 'package:pricecalc/features/group/group.dart';
import 'package:pricecalc/features/home/home.dart';
import 'package:pricecalc/features/price_list/price_list.dart';

class AddItemBottomSheet extends StatefulWidget {
  const AddItemBottomSheet({super.key, required this.prices});

  final List<Price> prices;

  @override
  State<AddItemBottomSheet> createState() => _AddItemBottomSheetState();
}

class _AddItemBottomSheetState extends State<AddItemBottomSheet> {
  bool _wrap = true;
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DraggableScrollableSheet(
      initialChildSize: 1,
      minChildSize: 0.5,
      maxChildSize: 1,
      builder: (context, controller) {
        return BottomSheetCustom(
          child: Column(
            spacing: 16,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 16,
                children: [
                  Flexible(
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: theme.hintColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          spacing: 10,
                          children: [
                            Icon(Icons.search),
                            Flexible(
                              child: TextFieldCustom(
                                onChanged: (_) => setState(() {}),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Найти...",
                                ),
                                controller: searchController,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      setState(() {
                        _wrap = !_wrap;
                      });
                    },
                    child: Ink(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: theme.hintColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(_wrap ? Icons.list_alt : Icons.window_sharp),
                    ),
                  ),
                ],
              ),
              widget.prices.isEmpty
                  ? SizedBox(
                    height: 200,
                    child: Center(
                      child: Text(
                        "У вас пока нет ни одной расценки",
                        style: theme.textTheme.headlineSmall,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                  : Builder(
                    builder: (context) {
                      final filteredPrices =
                          searchController.text.isEmpty
                              ? widget.prices
                              : widget.prices
                                  .where(
                                    (price) => (price.name ?? "").contains(
                                      searchController.text,
                                    ),
                                  )
                                  .toList();

                      return BlocSelector<GroupCubit, GroupState, List<Group>?>(
                        selector: (groupState) {
                          if (groupState is GroupLoaded) {
                            return groupState.groups;
                          }
                          return null;
                        },
                        builder:
                            (context, groups) => GroupedItemList(
                              prices: filteredPrices,
                              groups: groups,
                              type:
                                  _wrap
                                      ? GroupedItemListType.wrap
                                      : GroupedItemListType.list,
                            ),
                      );
                    },
                  ),
            ],
          ),
        );
      },
    );
  }
}
