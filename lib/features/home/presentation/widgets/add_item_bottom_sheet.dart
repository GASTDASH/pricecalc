import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pricecalc/core/presentation/widgets/bottom_sheet_custom.dart';
import 'package:pricecalc/features/home/home.dart';
import 'package:pricecalc/features/price_list/price_list.dart';

class AddItemBottomSheet extends StatefulWidget {
  const AddItemBottomSheet({super.key});

  @override
  State<AddItemBottomSheet> createState() => _AddItemBottomSheetState();
}

class _AddItemBottomSheetState extends State<AddItemBottomSheet> {
  bool _wrap = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<PriceBloc, PriceState>(
      builder: (context, state) {
        return DraggableScrollableSheet(
          initialChildSize: 1,
          minChildSize: 0.25,
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
                                  child: TextField(
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Найти...",
                                    ),
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
                          child: Icon(Icons.list),
                        ),
                      ),
                    ],
                  ),
                  state is PriceLoaded
                      ? _wrap
                          ? Expanded(
                            child: SingleChildScrollView(
                              controller: controller,
                              child: Wrap(
                                runSpacing: 12,
                                spacing: 12,
                                children: [
                                  for (var price in state.prices)
                                    ItemChip(price: price),
                                ],
                              ),
                            ),
                          )
                          : Expanded(
                            // height: MediaQuery.of(context).size.height - 364,
                            child: ListView.separated(
                              controller: controller,
                              itemCount: state.prices.length,
                              itemBuilder:
                                  (context, i) =>
                                      ItemTile(price: state.prices[i]),
                              separatorBuilder:
                                  (context, index) => Divider(height: 0),
                            ),
                          )
                      : Text("Not loaded yet"),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class ItemTile extends StatelessWidget {
  const ItemTile({super.key, required this.price});

  final Price price;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      title: Text(
        price.name ?? "Без названия",
        style: theme.textTheme.titleLarge,
      ),
      subtitle: Text(
        "Базовая цена: ${price.defaultPrice} ₽${(price.conditions.isNotEmpty) ? "  ·  ${price.conditions.length}" : ""}",
      ),
      onTap: () {},
    );
  }
}
