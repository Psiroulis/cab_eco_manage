import 'package:cab_economics/helpers/helper_methods.dart';
import 'package:cab_economics/models/shift.dart';
import 'package:cab_economics/widgets/rides/add_dialog.dart';
import 'package:flutter/material.dart';

class ShiftSummaryCard extends StatelessWidget {
  final Shift shift;

  const ShiftSummaryCard(this.shift, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(shift.start!.day.toString());
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                HelperMethods.formatDateToReadable(shift.start!),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Status'),
                  Text(
                    shift.end == null ? 'Running' : 'Completed',
                    style: TextStyle(
                        color: shift.end == null ? Colors.green : Colors.red),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total Black'),
                  Text(shift.totalIncomeBlack.toString()),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AddRideDialog(shift.start!),
                      );
                    },
                    child: const Text('Add Ride'),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
