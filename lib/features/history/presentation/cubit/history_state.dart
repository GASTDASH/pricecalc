part of 'history_cubit.dart';

sealed class HistoryState {}

final class HistoryLoaded extends HistoryState {
  HistoryLoaded({this.items = const []});

  final List<HistoryItem> items;
}

final class HistoryLoading extends HistoryState {}

final class HistoryError extends HistoryState {
  HistoryError({required this.error});

  final Object? error;
}
