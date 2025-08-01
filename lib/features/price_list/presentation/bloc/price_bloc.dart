import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pricecalc/features/price_list/price_list.dart';

part 'price_event.dart';
part 'price_state.dart';

class PriceBloc extends Bloc<PriceEvent, PriceState> {
  final PriceRepository _priceRepository;

  PriceBloc(this._priceRepository) : super(PriceLoaded()) {
    on<LoadPrices>((event, emit) async {
      try {
        emit(PriceLoading());

        final prices = await _priceRepository.getPrices();

        emit(PriceLoaded(prices: prices));
      } catch (e) {
        emit(PriceError(error: e, prices: state.prices));
      }
    });
    on<AddPrice>((event, emit) async {
      try {
        emit(PriceLoading());

        await _priceRepository.addPrice();
        final prices = await _priceRepository.getPrices();

        emit(PriceLoaded(prices: prices));
      } catch (e) {
        emit(PriceError(error: e, prices: state.prices));
      }
    });
    on<ClonePrice>((event, emit) async {
      try {
        emit(PriceLoading());

        await _priceRepository.addPrice(price: event.price);
        final prices = await _priceRepository.getPrices();

        emit(PriceLoaded(prices: prices));
      } catch (e) {
        emit(PriceError(error: e, prices: state.prices));
      }
    });
    on<RemovePrice>((event, emit) async {
      try {
        emit(PriceLoading());

        await _priceRepository.removePrice(event.uuid);
        final prices = await _priceRepository.getPrices();

        emit(PriceLoaded(prices: prices));
      } catch (e) {
        emit(PriceError(error: e, prices: state.prices));
      }
    });
    on<SavePrice>((event, emit) async {
      try {
        emit(PriceLoading());

        await _priceRepository.updatePrice(event.price);
        final prices = await _priceRepository.getPrices();

        emit(PriceLoaded(prices: prices));
      } catch (e) {
        emit(PriceError(error: e, prices: state.prices));
      }
    });
  }
}
