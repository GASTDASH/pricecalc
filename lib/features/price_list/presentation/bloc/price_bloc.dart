import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pricecalc/features/price_list/price_list.dart';

part 'price_event.dart';
part 'price_state.dart';

class PriceBloc extends Bloc<PriceEvent, PriceState> {
  final PriceRepository priceRepository;

  PriceBloc(this.priceRepository) : super(PriceLoaded()) {
    on<LoadPrices>((event, emit) async {
      try {
        emit(PriceLoading());

        final prices = await priceRepository.getPrices();

        emit(PriceLoaded(prices: prices));
      } catch (e) {
        emit(PriceError(prices: state.prices));
      }
    });
    on<AddPrice>((event, emit) async {
      try {
        emit(PriceLoading());

        await priceRepository.addPrice();
        final prices = await priceRepository.getPrices();

        emit(PriceLoaded(prices: prices));
      } catch (e) {
        emit(PriceError(prices: state.prices));
      }
    });
    on<RemovePrice>((event, emit) async {
      try {
        emit(PriceLoading());

        await priceRepository.removePrice(event.uuid);
        final prices = await priceRepository.getPrices();

        emit(PriceLoaded(prices: prices));
      } catch (e) {
        emit(PriceError(prices: state.prices));
      }
    });
    on<SavePrice>((event, emit) async {
      try {
        emit(PriceLoading());

        await priceRepository.updatePrice(event.price);
        final prices = await priceRepository.getPrices();

        emit(PriceLoaded(prices: prices));
      } catch (e) {
        emit(PriceError(prices: state.prices));
      }
    });
  }
}
