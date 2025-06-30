import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pricecalc/core/core.dart';
import 'package:pricecalc/features/group/group.dart';
import 'package:pricecalc/features/price_list/price_list.dart';

class AddGroupBottomSheet extends StatefulWidget {
  const AddGroupBottomSheet({super.key});

  @override
  State<AddGroupBottomSheet> createState() => _AddGroupBottomSheetState();
}

class _AddGroupBottomSheetState extends State<AddGroupBottomSheet> {
  late final GroupCubit _groupCubit;
  bool expanded = false;

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
        return NotificationListener<DraggableScrollableNotification>(
          onNotification: (notification) {
            if (notification.extent == 1) {
              setState(() => expanded = true);
            } else if (expanded) {
              setState(() => expanded = false);
            }
            return true;
          },
          child: DraggableScrollableSheet(
            initialChildSize: 0.75,
            minChildSize: 0.3,
            maxChildSize: 1,
            builder: (context, controller) {
              return BottomSheetCustom(
                padding: EdgeInsets.zero,
                borderRadius: expanded ? BorderRadius.zero : null,
                child: Column(
                  spacing: 16,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (state is GroupLoaded) ...[
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
                              itemBuilder: (context, i) {
                                final Group group = state.groups[i];

                                return ListTile(
                                  title: Text(
                                    (group.name == null || group.name! == "")
                                        ? "Без названия"
                                        : group.name!,
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        onPressed: () async {
                                          final String? newName =
                                              await showDialog(
                                                context: context,
                                                builder:
                                                    (context) => RenameDialog(
                                                      oldName: group.name,
                                                    ),
                                              );

                                          if (newName != null) {
                                            _groupCubit.updateGroup(
                                              group.copyWith(name: newName),
                                            );
                                          }
                                        },
                                        icon: Icon(Icons.edit),
                                      ),
                                      BlocSelector<
                                        PriceBloc,
                                        PriceState,
                                        List<Price>
                                      >(
                                        selector: (priceState) {
                                          if (priceState is PriceLoaded) {
                                            return priceState.prices;
                                          }
                                          return [];
                                        },
                                        builder: (context, prices) {
                                          return IconButton(
                                            onPressed: () {
                                              final index = prices.indexWhere(
                                                (price) =>
                                                    (price.groupUuid ?? "0") ==
                                                    group.uuid,
                                              );

                                              // Если нет ни одной цены с этой группой
                                              if (index == -1) {
                                                _groupCubit.removeGroup(
                                                  group.uuid,
                                                );
                                              } else {
                                                ScaffoldMessenger.of(
                                                  context,
                                                ).hideCurrentSnackBar();
                                                ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(
                                                  SnackBar(
                                                    backgroundColor:
                                                        theme.colorScheme.error,
                                                    content: Text(
                                                      "Нельзя удалить группу в которой есть цены",
                                                    ),
                                                  ),
                                                );
                                              }
                                            },
                                            icon: Icon(Icons.delete),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    Navigator.of(context).pop(group);
                                  },
                                );
                              },
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
                    ] else if (state is GroupLoading)
                      LoadingBanner(),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
