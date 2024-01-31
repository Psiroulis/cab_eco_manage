import 'package:cab_economics/helpers/CustomTextStyles.dart';
import 'package:cab_economics/models/shift.dart';
import 'package:cab_economics/providers/shift_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EndShiftDialog extends StatefulWidget {
  const EndShiftDialog({super.key});

  @override
  State<EndShiftDialog> createState() => _EndShiftDialogState();
}

class _EndShiftDialogState extends State<EndShiftDialog> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _tecNoTaxColl = TextEditingController();
  final TextEditingController _tecFpa = TextEditingController();
  final TextEditingController _tecFuelCost = TextEditingController();
  final TextEditingController _tecFuelLitre = TextEditingController();
  final TextEditingController _tecKm = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final shiftProvider = Provider.of<ShiftProvider>(context, listen: false);

    return Dialog.fullscreen(
      child: Consumer<ShiftProvider>(
        builder: (context, snapShot, child) {
          if (snapShot.isLoading == false) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'End Running Shift',
                      style: CustomTextStyles.dialogTitleBlack(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Collection No Taxed:',
                                style: CustomTextStyles.mediumBlack(),
                              ),
                              SizedBox(
                                width: 100,
                                child: TextFormField(
                                  controller: _tecNoTaxColl,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return '* Required';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.number,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'FPA tax:',
                                style: CustomTextStyles.mediumBlack(),
                              ),
                              SizedBox(
                                width: 100,
                                child: TextFormField(
                                  controller: _tecFpa,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return '* Required';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.number,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Fuel Cost:',
                                style: CustomTextStyles.mediumBlack(),
                              ),
                              SizedBox(
                                width: 100,
                                child: TextFormField(
                                  controller: _tecFuelCost,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return '* Required';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.number,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Fuel Price (per Litre):',
                                style: CustomTextStyles.mediumBlack(),
                              ),
                              SizedBox(
                                width: 100,
                                child: TextFormField(
                                  controller: _tecFuelLitre,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return '* Required';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.number,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Km Driven:',
                                style: CustomTextStyles.mediumBlack(),
                              ),
                              SizedBox(
                                width: 100,
                                child: TextFormField(
                                  controller: _tecKm,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return '* Required';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.number,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    Shift shift = Shift(
                                      totalIncome:
                                          double.parse(_tecNoTaxColl.text),
                                      totalFpa: double.parse(_tecFpa.text),
                                      fuelCost: double.parse(_tecFuelCost.text),
                                      km: int.parse(_tecKm.text),
                                      fuelLitrePrice:
                                          double.parse(_tecFuelLitre.text),
                                    );

                                    shiftProvider.endShift(shift).then(
                                        (value) => Navigator.pop(context));
                                  }
                                },
                                child: const Text('End Shift'),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Cancel'),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
