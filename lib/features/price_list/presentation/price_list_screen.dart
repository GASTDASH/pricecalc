import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:grouped_list/sliver_grouped_list.dart';
import 'package:pricecalc/core/core.dart';
import 'package:pricecalc/features/group/group.dart';
import 'package:pricecalc/features/price_list/price_list.dart';
import 'package:talker_flutter/talker_flutter.dart';

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
            slivers: [
              if (state is PriceLoading)
                SliverFillRemaining(child: LoadingBanner())
              else if (state is PriceError)
                SliverToBoxAdapter(child: ErrorBanner())
              else ...[
                SliverAppBar(title: Text("Прайс-лист")),
                SliverToBoxAdapter(child: SizedBox(height: 24)),

                if (state.prices.isNotEmpty)
                  BlocSelector<GroupCubit, GroupState, List<Group>?>(
                    selector: (groupState) {
                      if (groupState is GroupLoaded) {
                        return groupState.groups;
                      }
                      return null;
                    },
                    builder: (context, groups) {
                      bool hasNoGroup = false;

                      List<Group> groupsWithoutNoPrices = [];
                      if (groups != null) {
                        for (var gr in groups) {
                          if (state.prices.indexWhere((p) => p.groupUuid == gr.uuid) != -1) {
                            groupsWithoutNoPrices.add(gr);
                          }
                          if (state.prices.indexWhere((p) => p.groupUuid == null) != -1) {
                            hasNoGroup = true;
                          }
                        }
                      }

                      List<Price> sortedPrices = [];
                      sortedPrices = state.prices;
                      sortedPrices.sort((a, b) => (a.groupUuid ?? "0").compareTo(b.groupUuid ?? "0"));

                      GetIt.I<Talker>().info(state.prices.map((e) => e.groupUuid));
                      GetIt.I<Talker>().info(groupsWithoutNoPrices.map((e) => e.uuid));

                      return SliverPadding(
                        padding: const EdgeInsets.only(left: 24, right: 12),
                        sliver: SliverGroupedListView(
                          separator: SizedBox(height: 24),
                          elements: sortedPrices,
                          groupBy: (price) => price.groupUuid ?? "0",
                          itemBuilder: (context, price) => PriceRow(price: price),
                          itemComparator: (price1, price2) => (price1.groupUuid ?? "0").compareTo(price2.groupUuid ?? "0"),
                          groupComparator: (groupUuid1, groupUuid2) {
                            if (groupUuid1 == "0" || groupUuid2 == "0") {
                              return -1;
                            }

                            final group1 = (groupsWithoutNoPrices.firstWhere((g) => g.uuid == groupUuid1));
                            final group2 = (groupsWithoutNoPrices.firstWhere((g) => g.uuid == groupUuid2));

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
                                top: (groupUuid == "0" || (groupUuid == groupsWithoutNoPrices.first.uuid && !hasNoGroup)) ? 0 : 32,
                                bottom: 8,
                              ),
                              child: Text(
                                groupUuid == "0"
                                    ? "Без группы"
                                    : (group.name == null || group.name! == "")
                                    ? "Без названия"
                                    : group.name!,
                                style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  )
                else
                  SliverToBoxAdapter(child: NoPricesBanner()),
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
            ],
          ),
        );
      },
    );
  }
}
