import 'package:cab_economics/helpers/helper_methods.dart';
import 'package:cab_economics/models/shift.dart';
import 'package:cab_economics/widgets/rides/list_dialog.dart';
import 'package:flutter/material.dart';

class ShiftReportScreen extends StatefulWidget {
  final Shift shift;

  const ShiftReportScreen(this.shift, {super.key});

  @override
  State<ShiftReportScreen> createState() => _ShiftReportScreenState();
}

class _ShiftReportScreenState extends State<ShiftReportScreen> {
  @override
  Widget build(BuildContext context) {
    Shift shift = widget.shift;

    String appBarTitle =
        'Report  ${HelperMethods.formatDateToReadable(shift.start!)}';

    return Scaffold(
        appBar: AppBar(
          title: Text(appBarTitle),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Day:'),
                    Text(shift.day!),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Started:'),
                    Text(HelperMethods.timeToShow(shift.start!)),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Finished:'),
                    Text(
                      shift.end == null
                          ? 'Pending... '
                          : HelperMethods.timeToShow(shift.end!),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Rides Number:'),
                    Text('${shift.totalRides}'),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total income:'),
                    Text('${shift.totalIncomeBlack.toString()} €'),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Collection Pre Taxis:'),
                    Text('${shift.totalIncome} €'),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('VAT:'),
                    Text('${shift.totalFpa} €'),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Fuel Cost:'),
                    Text('${shift.fuelCost} €'),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Fuel Litre Price:'),
                    Text('${shift.fuelLitrePrice} €'),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Km Driven:'),
                    Text('${shift.km} km'),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => RideListDialog(shift),
                    );
                  },
                  child: const Text('Show Shift\'s Rides'),
                )
              ],
            ),
          ),
        ));
  }
}
