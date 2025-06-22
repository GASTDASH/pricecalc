import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pricecalc/core/core.dart';
import 'package:pricecalc/core/presentation/widgets/dialog_custom.dart';
import 'package:pricecalc/features/history/history.dart';
import 'package:pricecalc/features/home/home.dart';
import 'package:pricecalc/features/price_list/price_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeBloc _homeBloc;
  bool sortAlphabetically = false;

  @override
  void initState() {
    super.initState();

    _homeBloc = HomeBloc(
      calcItemRepository: GetIt.I<CalcItemRepository>(),
      priceBloc: BlocProvider.of<PriceBloc>(context),
    )..add(LoadCalcItems());
  }

  @override
  void dispose() {
    _homeBloc.close();

    super.dispose();
  }

  double sumAmount(List<CalcItem> calcItems) =>
      (calcItems.isNotEmpty)
          ? calcItems.fold<double>(
            0,
            (sum, calcItem) => sum + calcItem.totalPrice(),
          )
          : 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider(
      create: (context) => _homeBloc,
      child: Scaffold(
        persistentFooterButtons: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Итого:", style: theme.textTheme.headlineSmall),
                BlocBuilder<HomeBloc, HomeState>(
                  bloc: _homeBloc,
                  builder: (context, state) {
                    final double sum =
                        (state is HomeLoaded) ? sumAmount(state.calcItems) : 0;

                    return AnimatedSwitcher(
                      duration: Duration(milliseconds: 200),
                      transitionBuilder:
                          (child, animation) => SlideTransition(
                            position: Tween<Offset>(
                              begin: Offset(0, 1),
                              end: Offset(0, 0),
                            ).animate(animation),
                            child: FadeTransition(
                              opacity: animation,
                              child: child,
                            ),
                          ),
                      child: Text(
                        "${sum % 1 == 0 ? sum.truncate() : sum} ₽",
                        key: ValueKey(sum),
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text(
                "Калькулятор",
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () async {
                    await showDialog(
                      context: context,
                      builder:
                          (context) => DialogCustom(
                            title: "Сохранение",
                            text: "Сохранить данный расчёт в историю?",
                            child: Row(
                              spacing: 12,
                              children: [
                                Expanded(
                                  child: ButtonCustom(
                                    text: "Да",
                                    onTap: () {
                                      Navigator.of(context).pop();

                                      final double sum =
                                          (_homeBloc.state is HomeLoaded)
                                              ? sumAmount(
                                                _homeBloc.state.calcItems,
                                              )
                                              : 0;

                                      BlocProvider.of<HistoryCubit>(
                                        context,
                                      ).addHistoryItem(
                                        calcItems: _homeBloc.state.calcItems,
                                        totalAmount: sum,
                                      );
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: ButtonCustom(
                                    text: "Нет",
                                    outline: true,
                                    onTap: () => Navigator.of(context).pop(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                    );
                  },
                  icon: Icon(Icons.save_outlined),
                ),
                IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
              ],
            ),
            SliverToBoxAdapter(child: SizedBox(height: 6)),
            BlocBuilder<HomeBloc, HomeState>(
              bloc: _homeBloc,
              builder: (context, state) {
                return (state.calcItems.isNotEmpty)
                    ? SliverPadding(
                      padding: const EdgeInsets.only(left: 16),
                      sliver: SliverToBoxAdapter(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                sortAlphabetically = !sortAlphabetically;
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              spacing: 6,
                              children: [
                                Icon(
                                  sortAlphabetically
                                      ? Icons.sort_by_alpha
                                      : Icons.sort,
                                ),
                                Text.rich(
                                  TextSpan(
                                    text: "Сортировка: ",
                                    children: [
                                      TextSpan(
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                        text:
                                            sortAlphabetically
                                                ? "По алфавиту"
                                                : "По умолчанию",
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                    : SliverToBoxAdapter(child: SizedBox.shrink());
              },
            ),
            SliverToBoxAdapter(child: SizedBox(height: 6)),
            BlocBuilder<HomeBloc, HomeState>(
              bloc: _homeBloc,
              builder: (context, state) {
                if (state is HomeLoaded) {
                  if (state.calcItems.isEmpty) {
                    return SliverToBoxAdapter(
                      child: SizedBox(
                        height: 300,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          spacing: 12,
                          children: [
                            Text(
                              "Добавьте свой первый предмет для подсчёта",
                              style: theme.textTheme.headlineMedium,
                              textAlign: TextAlign.center,
                            ),
                            Text("Создать прайс можно на втором экране"),
                            Icon(Icons.arrow_downward_rounded, size: 64),
                          ],
                        ),
                      ),
                    );
                  } else {
                    var calcItems = state.calcItems.toList();
                    if (sortAlphabetically) {
                      calcItems.sort(
                        (a, b) =>
                            (a.price.name ?? "").compareTo(b.price.name ?? ""),
                      );
                    }

                    return SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      sliver: SliverReorderableList(
                        itemCount: calcItems.length,
                        itemBuilder: (context, i) {
                          final calcItem = calcItems[i];

                          return Padding(
                            key: ValueKey(i),
                            padding: const EdgeInsets.only(bottom: 24),
                            child: BlocProvider(
                              create: (context) => _homeBloc,
                              child: CalcItemRow(
                                calcItem: calcItem,
                                index: i,
                                onDismissed:
                                    (_) => _homeBloc.add(
                                      RemoveCalcItem(uuid: calcItem.uuid),
                                    ),
                                onChanged: (text) {
                                  try {
                                    _homeBloc.add(
                                      SaveCalcItem(
                                        calcItem: calcItem.copyWith(
                                          quantity: double.parse(text),
                                        ),
                                      ),
                                    );
                                  } catch (e) {
                                    if (Exception is FormatException) {
                                      debugPrint(
                                        "Ошибка при форматировании числа",
                                      );
                                    }
                                  }
                                },
                              ),
                            ),
                          );
                        },
                        onReorder: (oldIndex, newIndex) {},
                      ),
                    );
                  }
                } else if (state is HomeLoading) {
                  return SliverToBoxAdapter(child: LoadingBanner());
                } else if (state is HomeError) {
                  return SliverToBoxAdapter(
                    child: ErrorBanner(error: state.error.toString()),
                  );
                }
                return SliverToBoxAdapter(
                  child: Center(child: Text("HomeBloc: Неизвестное состояние")),
                );
              },
            ),
            BlocBuilder<PriceBloc, PriceState>(
              builder: (context, state) {
                return SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: ButtonCustom(
                      onTap: () async {
                        if (state is PriceLoaded) {
                          final Price? price = await showModalBottomSheetCustom(
                            context: context,
                            builder:
                                (context) =>
                                    AddItemBottomSheet(prices: state.prices),
                          );

                          if (price != null) {
                            _homeBloc.add(AddCalcItem(price: price));
                          }
                        } else if (state is PriceLoading) {
                          ScaffoldMessenger.of(context).removeCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Прайс ещё загружается")),
                          );
                        }
                      },
                      text: "Добавить",
                      icon: Icons.add,
                    ),
                  ),
                );
              },
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: BlocBuilder<HomeBloc, HomeState>(
                bloc: _homeBloc,
                builder: (context, state) {
                  if (state is HomeLoaded && state.calcItems.isNotEmpty) {
                    return Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 24),
                        child: Text(
                          "Сдвиньте предмет влево, чтобы удалить его",
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.hintColor,
                          ),
                        ),
                      ),
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
