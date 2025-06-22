import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pricecalc/core/core.dart';
import 'package:pricecalc/features/history/history.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late final HistoryCubit _historyCubit;

  @override
  void initState() {
    super.initState();

    _historyCubit = BlocProvider.of<HistoryCubit>(context)..loadHistory();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(title: Text("История")),
          BlocBuilder<HistoryCubit, HistoryState>(
            bloc: _historyCubit,
            builder: (context, state) {
              if (state is HistoryLoaded) {
                if (state.items.isEmpty) {
                  return SliverToBoxAdapter(
                    child: SizedBox(
                      height: 300,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        spacing: 12,
                        children: [
                          Text(
                            "У вас пока нет сохранённых расчётов",
                            style: theme.textTheme.headlineMedium,
                            textAlign: TextAlign.center,
                          ),
                          Icon(Icons.history_toggle_off, size: 64),
                        ],
                      ),
                    ),
                  );
                }
                var sortedItems =
                    state.items..sort((a, b) => b.savedAt.compareTo(a.savedAt));

                return SliverList.builder(
                  itemCount: sortedItems.length,
                  itemBuilder:
                      (context, i) => Padding(
                        padding: const EdgeInsets.all(12),
                        child: HistoryCard(historyItem: sortedItems[i]),
                      ),
                );
              }
              if (state is HistoryLoading) {
                return SliverToBoxAdapter(child: LoadingBanner());
              }
              if (state is HistoryError) {
                return SliverToBoxAdapter(
                  child: ErrorBanner(error: state.error.toString()),
                );
              }
              return SliverToBoxAdapter(
                child: Center(child: Text("HomeBloc: Неизвестное состояние")),
              );
            },
          ),
        ],
      ),
    );
  }
}
