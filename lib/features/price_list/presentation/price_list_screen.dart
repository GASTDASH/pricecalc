import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/sliver_grouped_list.dart';
import 'package:pricecalc/core/core.dart';
import 'package:pricecalc/features/group/group.dart';
import 'package:pricecalc/features/price_list/price_list.dart';

class PriceListScreen extends StatefulWidget {
  const PriceListScreen({super.key});

  @override
  State<PriceListScreen> createState() => _PriceListScreenState();
}

class _PriceListScreenState extends State<PriceListScreen> {
  late final PriceBloc _priceBloc;

  @override
  void initState() {
    super.initState();

    _priceBloc = BlocProvider.of<PriceBloc>(context)..add(LoadPrices());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<PriceBloc, PriceState>(
      builder: (context, state) {
        return Scaffold(
          body: CustomScrollView(
            slivers:
                state is PriceLoading
                    ? [SliverFillRemaining(child: LoadingBanner())]
                    : state is PriceError
                    ? [SliverToBoxAdapter(child: ErrorBanner())]
                    : [
                      SliverAppBar(title: Text("Прайс-лист")),
                      SliverToBoxAdapter(child: SizedBox(height: 24)),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 24, right: 12),
                          child:
                              (state is PriceLoaded && state.prices.isNotEmpty)
                                  ? Column(
                                    spacing: 24,
                                    children: [
                                      for (var price in state.prices)
                                        PriceRow(price: price),
                                    ],
                                  )
                                  : state.prices.isEmpty
                                  ? NoPricesBanner()
                                  : Center(child: Text("Что-то пошло не так!")),
                        ),
                      ),
                      SliverToBoxAdapter(child: Divider(height: 64)),
                      SliverGroupedListView(
                        elements: state.prices,
                        groupBy: (e) => e.groupUuid ?? "0",
                        itemBuilder:
                            (context, e) => Text(
                              (e.name == null) ? "Без названия" : e.name!,
                            ),
                        groupSeparatorBuilder:
                            (
                              String groupUuid,
                            ) => BlocBuilder<GroupCubit, GroupState>(
                              builder: (context, groupState) {
                                if (groupState is GroupLoaded) {
                                  return Text(
                                    groupUuid == "0"
                                        ? "Без группы"
                                        : groupState.groups
                                                .firstWhere(
                                                  (group) =>
                                                      group.uuid == groupUuid,
                                                )
                                                .name ??
                                            "Без названия", // TODO: Подстановка имени группы
                                    style: theme.textTheme.titleLarge,
                                  );
                                }
                                return Text(
                                  "...", // TODO: Подстановка имени группы
                                  style: theme.textTheme.titleLarge,
                                );
                              },
                            ),
                      ),
                      SliverToBoxAdapter(child: SizedBox(height: 24)),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: ButtonCustom(
                            onTap:
                                state is PriceLoading
                                    ? null
                                    : () {
                                      _priceBloc.add(AddPrice());
                                    },
                            isLoading: state is PriceLoading,
                            text: "Добавить",
                            icon: Icons.add,
                          ),
                        ),
                      ),
                    ],
          ),
        );
      },
    );
  }
}
