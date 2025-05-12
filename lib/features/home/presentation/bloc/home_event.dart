part of 'home_bloc.dart';

sealed class HomeEvent {}

final class LoadCalcItems extends HomeEvent {}

final class AddCalcItem extends HomeEvent {
  AddCalcItem({required this.price});

  final Price price;
}

final class RemoveCalcItem extends HomeEvent {
  RemoveCalcItem({required this.uuid});

  final String uuid;
}

final class SaveCalcItem extends HomeEvent {
  SaveCalcItem({required this.calcItem});

  final CalcItem calcItem;
}
