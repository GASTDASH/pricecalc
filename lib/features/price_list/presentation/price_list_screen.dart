import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pricecalc/core/core.dart';
import 'package:pricecalc/features/price_list/price_list.dart';

class PriceListScreen extends StatefulWidget {
  const PriceListScreen({super.key});

  @override
  State<PriceListScreen> createState() => _PriceListScreenState();
}

class _PriceListScreenState extends State<PriceListScreen> {
  late final ItemsBloc _itemsBloc;

  @override
  void initState() {
    super.initState();

    _itemsBloc = context.read<ItemsBloc>();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      persistentFooterButtons: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ButtonCustom(text: "Сохранить", onTap: null),
        ),
      ],
      body: BlocBuilder<ItemsBloc, ItemsState>(
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(title: Text("Прайс-лист")),
              SliverToBoxAdapter(child: SizedBox(height: 24)),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(left: 24, right: 12),
                  child:
                      state is ItemsLoaded && state.items.isNotEmpty
                          ? Column(
                            spacing: 24,
                            children: [
                              for (var item in state.items)
                                ItemEditRow(item: item),
                            ],
                          )
                          : state.items.isEmpty
                          ? Padding(
                            padding: const EdgeInsets.only(top: 100),
                            child: Center(
                              child: Column(
                                spacing: 24,
                                children: [
                                  Text(
                                    "Вы пока не добавили ни одного товара",
                                    style: theme.textTheme.headlineMedium,
                                    textAlign: TextAlign.center,
                                  ),
                                  Icon(Icons.arrow_downward_rounded, size: 64),
                                ],
                              ),
                            ),
                          )
                          : Center(child: CircularProgressIndicator()),
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 24)),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: ButtonCustom(
                    onTap:
                        state is ItemsLoading
                            ? null
                            : () {
                              _itemsBloc.add(ItemsAdd(item: Item()));
                            },
                    isLoading: state is ItemsLoading,
                    text: "Добавить",
                    icon: Icons.add,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
