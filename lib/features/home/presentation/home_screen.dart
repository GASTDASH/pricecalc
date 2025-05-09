import 'package:flutter/material.dart';
import 'package:pricecalc/core/core.dart';
import 'package:pricecalc/features/home/home.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      persistentFooterButtons: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Итого:", style: theme.textTheme.headlineSmall),
              Text(
                "1288 ₽",
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text("Калькулятор"),
            actions: [IconButton(onPressed: () {}, icon: Icon(Icons.edit))],
          ),
          SliverToBoxAdapter(child: SizedBox(height: 24)),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            sliver: SliverReorderableList(
              itemCount: 4,
              itemBuilder:
                  (context, i) => Padding(
                    key: ValueKey(i),
                    padding: const EdgeInsets.only(bottom: 24),
                    child: ItemRow(index: i),
                  ),
              onReorder: (oldIndex, newIndex) => () {},
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: ButtonCustom(
                onTap: () {
                  showModalBottomSheetCustom(
                    context: context,
                    builder: (context) => AddItemBottomSheet(),
                  );
                },
                text: "Добавить",
                icon: Icons.add,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
