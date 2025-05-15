import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pricecalc/core/core.dart';
import 'package:pricecalc/features/group/group.dart';

class AddGroupBottomSheet extends StatefulWidget {
  const AddGroupBottomSheet({super.key});

  @override
  State<AddGroupBottomSheet> createState() => _AddGroupBottomSheetState();
}

class _AddGroupBottomSheetState extends State<AddGroupBottomSheet> {
  late final GroupCubit _groupCubit;

  @override
  void initState() {
    super.initState();

    _groupCubit = BlocProvider.of<GroupCubit>(context)..getGroups();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<GroupCubit, GroupState>(
      bloc: _groupCubit,
      builder: (context, state) {
        return DraggableScrollableSheet(
          initialChildSize: 1,
          minChildSize: 0.5,
          maxChildSize: 1,
          builder: (context, controller) {
            return BottomSheetCustom(
              child: Column(
                spacing: 16,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (state is GroupLoaded)
                    state.groups.isEmpty
                        ? SizedBox(
                          height: 200,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              spacing: 12,
                              children: [
                                Text(
                                  "У вас пока нет групп",
                                  style: theme.textTheme.headlineSmall,
                                  textAlign: TextAlign.center,
                                ),
                                Icon(Icons.arrow_downward_rounded, size: 64),
                              ],
                            ),
                          ),
                        )
                        : Expanded(
                          child: ListView.separated(
                            controller: controller,
                            itemCount: state.groups.length,
                            itemBuilder:
                                (context, i) => ListTile(
                                  title: Text(
                                    state.groups[i].name ?? "Без названия",
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.edit),
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.delete),
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    Navigator.of(context).pop(state.groups[i]);
                                  },
                                ),
                            separatorBuilder:
                                (context, index) => Divider(height: 0),
                          ),
                        ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: ButtonCustom(
                      text: "Создать группу",
                      icon: Icons.add,
                      onTap: () {
                        _groupCubit.addGroup();
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
