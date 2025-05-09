import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pricecalc/core/core.dart';
import 'package:pricecalc/features/price_list/price_list.dart';

class PriceRow extends StatefulWidget {
  const PriceRow({super.key, required this.price});

  final Price price;

  @override
  State<PriceRow> createState() => _PriceRowState();
}

class _PriceRowState extends State<PriceRow> {
  final nameController = TextEditingController();
  final unitsController = TextEditingController();
  final priceController = TextEditingController();

  late final PriceBloc _priceBloc;

  @override
  void initState() {
    super.initState();

    _priceBloc = context.read<PriceBloc>();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      spacing: 8,
      children: [
        Expanded(
          flex: 6,
          child: TextFieldCustom(
            decoration: InputDecoration(hintText: "Название"),
            controller: nameController..text = widget.price.name ?? "",
            onTapOutside: () {
              _priceBloc.add(
                SavePrice(
                  price: widget.price.copyWith(name: nameController.text),
                ),
              );
            },
          ),
        ),
        Expanded(
          flex: 2,
          child: TextFieldCustom(
            textAlign: TextAlign.center,
            decoration: InputDecoration(hintText: "(шт.)"),
            controller: unitsController..text = widget.price.units ?? "",
            onTapOutside: () {
              _priceBloc.add(
                SavePrice(
                  price: widget.price.copyWith(units: unitsController.text),
                ),
              );
            },
          ),
        ),
        Expanded(
          flex: 3,
          child: Row(
            children: [
              Flexible(
                child: TextFieldCustom(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(hintText: "0"),
                  controller:
                      priceController
                        ..text = widget.price.defaultPrice.toString(),
                  keyboardType: TextInputType.number,
                  onTapOutside: () {
                    try {
                      _priceBloc.add(
                        SavePrice(
                          price: widget.price.copyWith(
                            defaultPrice: double.parse(priceController.text),
                          ),
                        ),
                      );
                    } catch (e) {
                      if (Exception is FormatException) {
                        debugPrint("Ошибка при форматировании числа");
                      }
                    }
                  },
                ),
              ),
              Text("₽", style: TextStyle(fontSize: 18)),
            ],
          ),
        ),
        Row(
          children: [
            IconButton(
              onPressed:
                  () => {
                    showModalBottomSheetCustom(
                      context: context,
                      builder: (context) => EditConditionsBottomSheet(),
                    ),
                  },
              icon:
                  widget.price.conditions.isNotEmpty
                      ? Badge(
                        alignment: Alignment.bottomRight,
                        backgroundColor: theme.primaryColor,
                        label: Text("${widget.price.conditions.length}"),
                        child: Icon(Icons.edit),
                      )
                      : Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () {
                _priceBloc.add(RemovePrice(uuid: widget.price.uuid));
              },
              icon: Icon(Icons.delete),
            ),
          ],
        ),
      ],
    );
  }
}

// class TextFieldCustomSaving extends TextFieldCustom {
//   const TextFieldCustomSaving({
//     super.key,
//     super.controller,
//     super.decoration,
//     super.keyboardType,
//     super.onTapOutside,
//     super.style,
//     super.textAlign,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return TextFieldCustom(
//       controller: controller,
//       decoration: decoration,
//       keyboardType: keyboardType,
//       onTapOutside: () {

//       },
//       style: style,
//       textAlign: textAlign,
//     );
//   }
// }
