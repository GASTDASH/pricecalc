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
  late final PriceBloc _priceBloc;

  @override
  void initState() {
    super.initState();

    _priceBloc = context.read<PriceBloc>()..add(LoadPrices());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PriceBloc, PriceState>(
      builder: (context, state) {
        return Scaffold(
          body: CustomScrollView(
            slivers:
                state is PriceLoading
                    ? [SliverFillRemaining(child: CircularProgressIndicator())]
                    : state is PriceError
                    ? [SliverToBoxAdapter(child: ErrorBanner())]
                    : [
                      SliverAppBar(title: Text("Прайс-лист")),
                      SliverToBoxAdapter(child: SizedBox(height: 24)),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 24, right: 12),
                          child:
                              state is PriceLoaded && state.prices.isNotEmpty
                                  ? Column(
                                    spacing: 24,
                                    children: [
                                      for (var price in state.prices)
                                        PriceRow(price: price),
                                    ],
                                  )
                                  : state.prices.isEmpty
                                  ? NoPricesBanner()
                                  : Center(child: CircularProgressIndicator()),
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
