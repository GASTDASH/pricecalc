import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pricecalc/features/home/home.dart';
import 'package:pricecalc/features/price_list/price_list.dart';
import 'package:pricecalc/features/root/root.dart';
import 'package:pricecalc/features/settings/settings.dart';

CustomTransitionPage buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionDuration: Duration(seconds: 2),
    transitionsBuilder:
        (context, animation, secondaryAnimation, child) => FadeTransition(
          opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
          child: child,
        ),
  );
}

final router = GoRouter(
  initialLocation: '/home',
  routes: [
    StatefulShellRoute(
      builder: (context, state, navigationShell) => navigationShell,
      navigatorContainerBuilder:
          (context, navigationShell, children) =>
              RootScreen(navigationShell: navigationShell, children: children),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              pageBuilder:
                  (context, state) => buildPageWithDefaultTransition(
                    context: context,
                    state: state,
                    child: HomeScreen(),
                  ),
            ),
          ],
        ),
        StatefulShellBranch(
          preload: true,
          routes: [
            GoRoute(
              path: '/price-list',
              pageBuilder:
                  (context, state) => buildPageWithDefaultTransition(
                    context: context,
                    state: state,
                    child: PriceListScreen(),
                  ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/settings',
              pageBuilder:
                  (context, state) => buildPageWithDefaultTransition(
                    context: context,
                    state: state,
                    child: SettingsScreen(),
                  ),
            ),
          ],
        ),
      ],
    ),
  ],
);
