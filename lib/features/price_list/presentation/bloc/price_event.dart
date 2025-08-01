part of 'price_bloc.dart';

sealed class PriceEvent {}

final class LoadPrices extends PriceEvent {}

final class AddPrice extends PriceEvent {}

final class ClonePrice extends PriceEvent {
  ClonePrice({required this.price});

  final Price price;
}

final class SavePrice extends PriceEvent {
  SavePrice({required this.price});

  final Price price;
}

final class RemovePrice extends PriceEvent {
  RemovePrice({required this.uuid});

  final String uuid;
}

final class SaveConditions extends PriceEvent {}

final class RemoveCondition extends PriceEvent {}
