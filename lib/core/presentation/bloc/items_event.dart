part of 'items_bloc.dart';

sealed class ItemsEvent {}

final class ItemsAdd extends ItemsEvent {
  ItemsAdd({required this.item});

  final Item item;
}

final class ItemsEdit extends ItemsEvent {}

final class ItemsRemove extends ItemsEvent {}

final class ItemsSaveConditions extends ItemsEvent {}

final class ItemsRemoveCondition extends ItemsEvent {}
