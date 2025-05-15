import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pricecalc/features/group/group.dart';

part 'group_state.dart';

class GroupCubit extends Cubit<GroupState> {
  GroupCubit(this._groupRepository) : super(GroupLoaded());

  final GroupRepository _groupRepository;

  void getGroups() async {
    try {
      emit(GroupLoading());

      final groups = await _groupRepository.getGroups();

      emit(GroupLoaded(groups: groups));
    } catch (e) {
      emit(GroupError(error: e));
    }
  }

  void addGroup() async {
    try {
      emit(GroupLoading());

      await _groupRepository.addGroup();
      final groups = await _groupRepository.getGroups();

      emit(GroupLoaded(groups: groups));
    } catch (e) {
      emit(GroupError(error: e));
    }
  }

  void removeGroup(String uuid) async {
    try {
      emit(GroupLoading());

      await _groupRepository.removeGroup(uuid);
      final groups = await _groupRepository.getGroups();

      emit(GroupLoaded(groups: groups));
    } catch (e) {
      emit(GroupError(error: e));
    }
  }

  void updateGroup(Group group) async {
    try {
      emit(GroupLoading());

      await _groupRepository.updateGroup(group);
      final groups = await _groupRepository.getGroups();

      emit(GroupLoaded(groups: groups));
    } catch (e) {
      emit(GroupError(error: e));
    }
  }
}
