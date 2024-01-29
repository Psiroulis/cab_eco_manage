import 'package:cab_economics/models/shift.dart';
import 'package:cab_economics/providers/shift_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EndShiftDialog extends StatelessWidget {
  const EndShiftDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final shiftProvider = Provider.of<ShiftProvider>(context, listen: false);
    final formKey = GlobalKey<FormState>();

    final TextEditingController edtNoTaxController = TextEditingController();
    final TextEditingController edtFPATaxController = TextEditingController();
    final TextEditingController edtFuelCostController = TextEditingController();
    final TextEditingController edtFuelLitrePriceController =
        TextEditingController();
    final TextEditingController edtKilometersController =
        TextEditingController();

    return AlertDialog(
      surfaceTintColor: Colors.white,
      content: Padding(
        padding: EdgeInsets.all(4.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Import Shift Data'),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: edtNoTaxController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'No Tax Collection',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: edtFPATaxController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Fpa Tax',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: edtFuelCostController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Fuel cost',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: edtFuelLitrePriceController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Fuel Litre Price',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: edtKilometersController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Kilometers',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      Navigator.pop(context);

                      Shift shift = Shift(
                        totalIncome: double.parse(edtNoTaxController.text),
                        totalFpa: double.parse(edtFPATaxController.text),
                        fuelCost: double.parse(edtFuelCostController.text),
                        km: int.parse(edtKilometersController.text),
                        fuelLitrePrice:
                            double.parse(edtFuelLitrePriceController.text),
                      );

                      shiftProvider.endShift(shift);
                    }
                  },
                  child: const Text('End Shift'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
