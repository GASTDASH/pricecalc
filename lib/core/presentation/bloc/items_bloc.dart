import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pricecalc/core/core.dart';

part 'items_event.dart';
part 'items_state.dart';

class ItemsBloc extends Bloc<ItemsEvent, ItemsState> {
  ItemsBloc() : super(ItemsLoaded()) {
    on<ItemsAdd>((event, emit) {
      try {
        emit(ItemsLoading());
        emit(ItemsLoaded());
      } catch (e) {
        emit(ItemsError(items: state.items));
      }
    });
  }
}
