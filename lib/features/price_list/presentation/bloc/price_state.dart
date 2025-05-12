part of 'price_bloc.dart';

sealed class PriceState {
  PriceState({this.prices = const []});

  final List<Price> prices;
}

final class PriceLoading extends PriceState {
  PriceLoading({super.prices});
}

final class PriceLoaded extends PriceState {
  PriceLoaded({super.prices});
}

final class PriceError extends PriceState {
  PriceError({super.prices, this.error});

  final Object? error;
}
