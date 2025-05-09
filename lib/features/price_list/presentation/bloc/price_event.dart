part of 'price_bloc.dart';

sealed class PriceEvent {}

final class LoadPrices extends PriceEvent {}

final class AddPrice extends PriceEvent {}

final class SavePrices extends PriceEvent {
  SavePrices({required this.pricesId});

  final List<String> pricesId;
}

final class RemovePrice extends PriceEvent {
  RemovePrice({required this.uuid});

  final String uuid;
}

final class SaveConditions extends PriceEvent {}

final class RemoveCondition extends PriceEvent {}
