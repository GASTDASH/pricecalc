import 'package:hive_flutter/hive_flutter.dart';
import 'package:pricecalc/features/group/group.dart';
import 'package:uuid/uuid.dart';

class GroupRepository {
  final Box<Group> _box = Hive.box('groups');

  Future<List<Group>> getGroups() async =>
      _box.values.toList()
        ..sort((a, b) => (a.name ?? "").compareTo((b.name ?? "")));

  Future<void> addGroup() async {
    var uuid = Uuid().v4();
    _box.put(uuid, Group(uuid: uuid));
  }

  Future<void> removeGroup(String uuid) async => _box.delete(uuid);

  Future<void> updateGroup(Group group) async => _box.put(group.uuid, group);
}
