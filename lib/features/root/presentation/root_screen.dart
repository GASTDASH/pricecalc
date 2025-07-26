import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pricecalc/features/group/group.dart';
import 'package:pricecalc/features/price_list/price_list.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({
    super.key,
    required this.navigationShell,
    required this.children,
  });

  final StatefulNavigationShell navigationShell;
  final List<Widget> children;

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  late final PageController _controller;

  @override
  void initState() {
    super.initState();

    _controller = PageController(
      initialPage: widget.navigationShell.currentIndex,
    );
    BlocProvider.of<PriceBloc>(context).add(LoadPrices());
    BlocProvider.of<GroupCubit>(context).getGroups();
  }

  @override
  void didUpdateWidget(covariant RootScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    final navigationShell = widget.navigationShell;
    final page = _controller.page ?? _controller.initialPage;
    final index = page.round();
    // Ignore swipe events.
    if (index == navigationShell.currentIndex) {
      return;
    }
    _controller.animateToPage(
      widget.navigationShell.currentIndex,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOutCirc,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: PageView.builder(
        controller: _controller,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => widget.children[index],
        onPageChanged: (index) {
          // Ignore tap events.
          if (index == widget.navigationShell.currentIndex) {
            return;
          }
          widget.navigationShell.goBranch(index, initialLocation: false);
        },

        itemCount: widget.children.length,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: items,
        currentIndex: widget.navigationShell.currentIndex,
        fixedColor: theme.primaryColor,
        unselectedItemColor: theme.hintColor,
        onTap:
            (index) => widget.navigationShell.goBranch(
              index,
              initialLocation: index == widget.navigationShell.currentIndex,
            ),
      ),
    );
  }

  List<BottomNavigationBarItem> get items => [
    BottomNavigationBarItem(icon: Icon(Icons.calculate), label: "Расчёт"),
    BottomNavigationBarItem(
      icon: Icon(Icons.request_quote),
      label: "Прайс-лист",
    ),
    BottomNavigationBarItem(icon: Icon(Icons.history), label: "История"),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Настройки"),
  ];
}
