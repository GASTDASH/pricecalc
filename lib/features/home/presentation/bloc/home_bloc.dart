import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pricecalc/features/home/home.dart';
import 'package:pricecalc/features/price_list/price_list.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final CalcItemRepository _calcItemRepository;

  final PriceBloc _priceBloc;
  late StreamSubscription _priceSubscription;

  @override
  Future<void> close() {
    _priceSubscription.cancel();
    return super.close();
  }

  HomeBloc({
    required CalcItemRepository calcItemRepository,
    required PriceBloc priceBloc,
  }) : _calcItemRepository = calcItemRepository,
       _priceBloc = priceBloc,
       super(HomeLoaded()) {
    // УРА Я ЭТО СДЕЛАЛ
    _priceSubscription = _priceBloc.stream.listen((state) async {
      if (state is PriceLoaded) {
        // Обновление нужных записи в Box'е
        final calcItems = await _calcItemRepository.getCalcItems();
        for (var price in state.prices) {
          for (var calcItem in calcItems) {
            if (price.uuid == calcItem.price.uuid) {
              await _calcItemRepository.updateCalcItem(
                calcItem.copyWith(price: price),
              );
            }
          }
        }

        add(LoadCalcItems());
      }
    });

    on<LoadCalcItems>((event, emit) async {
      try {
        emit(HomeLoading());

        final calcItems = await _calcItemRepository.getCalcItems();

        emit(HomeLoaded(calcItems: calcItems));
      } catch (e) {
        emit(HomeError(error: e, calcItems: state.calcItems));
      }
    });
    on<AddCalcItem>((event, emit) async {
      try {
        emit(HomeLoading());

        _calcItemRepository.addCalcItem(event.price);
        final calcItems = await _calcItemRepository.getCalcItems();

        emit(HomeLoaded(calcItems: calcItems));
      } catch (e) {
        emit(HomeError(error: e, calcItems: state.calcItems));
      }
    });
    on<RemoveCalcItem>((event, emit) async {
      try {
        emit(HomeLoading());

        _calcItemRepository.removeCalcItem(event.uuid);
        final calcItems = await _calcItemRepository.getCalcItems();

        emit(HomeLoaded(calcItems: calcItems));
      } catch (e) {
        emit(HomeError(error: e, calcItems: state.calcItems));
      }
    });
    on<SaveCalcItem>((event, emit) async {
      try {
        emit(HomeLoading());

        _calcItemRepository.updateCalcItem(event.calcItem);
        final calcItems = await _calcItemRepository.getCalcItems();

        emit(HomeLoaded(calcItems: calcItems));
      } catch (e) {
        emit(HomeError(error: e, calcItems: state.calcItems));
      }
    });
  }
}
