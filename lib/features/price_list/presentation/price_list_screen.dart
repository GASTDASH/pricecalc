import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return BlocBuilder<PriceBloc, PriceState>(
      builder: (context, state) {
        return Scaffold(
          body: RefreshIndicator(
            onRefresh: () async {
              _priceBloc.add(LoadPrices());
            },
            child: CustomScrollView(
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
                        if (groups != null) {
                          // TODO: Сделать скрытие групп
                          return GroupedPriceList(
                            prices: state.prices,
                            padding: const EdgeInsets.only(left: 24, right: 12),
                            groups: groups,
                          );
                        }
                        return SliverFillRemaining(child: LoadingBanner());
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
          ),
        );
      },
    );
  }
}
