part of 'group_cubit.dart';

sealed class GroupState {}

final class GroupLoaded extends GroupState {
  GroupLoaded({this.groups = const []});

  final List<Group> groups;
}

final class GroupLoading extends GroupState {}

final class GroupError extends GroupState {
  GroupError({required this.error});

  final Object? error;
}
