import 'package:flutter/material.dart';
import 'package:pricecalc/core/presentation/widgets/bottom_sheet_custom.dart';
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
                  : _wrap
                  ? Expanded(
                    child: SingleChildScrollView(
                      controller: controller,
                      child: Wrap(
                        runSpacing: 12,
                        spacing: 12,
                        children: [
                          for (var price in widget.prices)
                            ItemChip(
                              price: price,
                              onTap: () {
                                Navigator.of(context).pop(price);
                              },
                            ),
                        ],
                      ),
                    ),
                  )
                  : Expanded(
                    // height: MediaQuery.of(context).size.height - 364,
                    child: ListView.separated(
                      controller: controller,
                      itemCount: widget.prices.length,
                      itemBuilder:
                          (context, i) => ItemTile(
                            price: widget.prices[i],
                            onTap: () {
                              Navigator.of(context).pop(widget.prices[i]);
                            },
                          ),
                      separatorBuilder: (context, index) => Divider(height: 0),
                    ),
                  ),
            ],
          ),
        );
      },
    );
  }
}
