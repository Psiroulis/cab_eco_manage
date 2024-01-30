import 'package:cab_economics/helpers/CustomTextStyles.dart';
import 'package:cab_economics/helpers/helper_methods.dart';
import 'package:cab_economics/models/shift.dart';
import 'package:cab_economics/providers/shift_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddShiftDialog extends StatefulWidget {
  const AddShiftDialog({super.key});

  @override
  State<AddShiftDialog> createState() => _AddShiftDialogState();
}

class _AddShiftDialogState extends State<AddShiftDialog> {
  final _formKey = GlobalKey<FormState>();

  DateTime _selectedDate = DateTime.now();

  final TextEditingController _tecTotalBlack = TextEditingController();
  final TextEditingController _tecTotalCollection = TextEditingController();
  final TextEditingController _tecTotalFPA = TextEditingController();
  final TextEditingController _tecTotalFuelCost = TextEditingController();
  final TextEditingController _tecTotalFuelLitrePrice = TextEditingController();
  final TextEditingController _tecTotalKm = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                'Add New Shift',
                style: CustomTextStyles.dialogTitleBlack(),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2022),
                                    lastDate: DateTime.now())
                                .then((value) {
                              setState(() {
                                _selectedDate = value!;
                              });
                            });
                          },
                          child: const Text('Select Date'),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Text(
                            HelperMethods.formatDateToReadable(_selectedDate),
                            textAlign: TextAlign.end,
                            style: CustomTextStyles.mediumBlackBold(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total Black'),
                        SizedBox(
                          width: 100.0,
                          child: TextFormField(
                            controller: _tecTotalBlack,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '';
                              }

                              return null;
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total Collection'),
                        SizedBox(
                          width: 100.0,
                          child: TextFormField(
                            controller: _tecTotalCollection,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '';
                              }

                              return null;
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total FPA'),
                        SizedBox(
                          width: 100.0,
                          child: TextFormField(
                            controller: _tecTotalFPA,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '';
                              }

                              return null;
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Fuel Cost'),
                        SizedBox(
                          width: 100.0,
                          child: TextFormField(
                            controller: _tecTotalFuelCost,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '';
                              }

                              return null;
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Fuel litre price'),
                        SizedBox(
                          width: 100.0,
                          child: TextFormField(
                            controller: _tecTotalFuelLitrePrice,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '';
                              }

                              return null;
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Km Drive'),
                        SizedBox(
                          width: 100.0,
                          child: TextFormField(
                            controller: _tecTotalKm,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '';
                              }

                              return null;
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Provider.of<ShiftProvider>(context, listen: false)
                          .createShiftRetrochronized(createShiftForStore());

                      Navigator.pop(context);
                    },
                    child: const Text('Add'),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Shift createShiftForStore() {
    return Shift(
      start: _selectedDate,
      end: _selectedDate,
      totalIncomeBlack: _tecTotalBlack.text.isEmpty
          ? 0
          : double.tryParse(_tecTotalBlack.text),
      totalIncome: _tecTotalCollection.text.isEmpty
          ? 0
          : double.tryParse(_tecTotalCollection.text),
      totalFpa:
          _tecTotalFPA.text.isEmpty ? 0 : double.tryParse(_tecTotalFPA.text),
      fuelCost: _tecTotalFuelCost.text.isEmpty
          ? 0
          : double.parse(_tecTotalFuelCost.text),
      fuelLitrePrice: _tecTotalFuelLitrePrice.text.isEmpty
          ? 0
          : double.tryParse(_tecTotalFuelLitrePrice.text),
      km: _tecTotalKm.text.isEmpty ? 0 : int.tryParse(_tecTotalKm.text),
    );
  }
}
