part of 'home_bloc.dart';

sealed class HomeState {
  HomeState({this.calcItems = const []});

  final List<CalcItem> calcItems;
}

final class HomeLoading extends HomeState {
  HomeLoading({super.calcItems});
}

final class HomeLoaded extends HomeState {
  HomeLoaded({super.calcItems});
}

final class HomeError extends HomeState {
  HomeError({super.calcItems, this.error});

  final Object? error;
}
