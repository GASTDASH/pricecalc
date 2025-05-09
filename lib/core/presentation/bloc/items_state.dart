part of 'items_bloc.dart';

sealed class ItemsState {
  ItemsState({this.items = const []});

  final List<Item> items;
}

final class ItemsLoading extends ItemsState {
  ItemsLoading({super.items});
}

final class ItemsLoaded extends ItemsState {
  ItemsLoaded({super.items});
}

final class ItemsError extends ItemsState {
  ItemsError({super.items});
}
