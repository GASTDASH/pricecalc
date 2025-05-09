import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pricecalc/features/price_list/price_list.dart';
import 'package:uuid/uuid.dart';

part 'price_event.dart';
part 'price_state.dart';

class PriceBloc extends Bloc<PriceEvent, PriceState> {
  PriceBloc() : super(PriceLoaded()) {
    on<LoadPrices>((event, emit) async {
      try {
        emit(PriceLoading());

        final pricesBox = Hive.box<Price>('prices');

        emit(PriceLoaded(prices: pricesBox.values.toList()));
      } catch (e) {
        emit(PriceError(prices: state.prices));
      }
    });
    on<AddPrice>((event, emit) async {
      try {
        emit(PriceLoading());

        final pricesBox = Hive.box<Price>('prices');
        var uuid = Uuid().v4();
        pricesBox.put(uuid, Price(uuid: uuid));

        emit(PriceLoaded(prices: pricesBox.values.toList()));
      } catch (e) {
        emit(PriceError(prices: state.prices));
      }
    });
    on<RemovePrice>((event, emit) async {
      try {
        emit(PriceLoading());

        final pricesBox = Hive.box<Price>('prices');
        pricesBox.delete(event.uuid);

        emit(PriceLoaded(prices: pricesBox.values.toList()));
      } catch (e) {
        emit(PriceError(prices: state.prices));
      }
    });
  }
}
