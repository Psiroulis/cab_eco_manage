import 'package:cab_economics/helpers/CustomButtonStyles.dart';
import 'package:cab_economics/helpers/CustomTextStyles.dart';
import 'package:cab_economics/providers/shift_provider.dart';
import 'package:cab_economics/widgets/add_new_ride_to_shift_dialog.dart';
import 'package:cab_economics/widgets/end_shift_dialog.dart';
import 'package:cab_economics/widgets/shift_report_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../helpers/helper_methods.dart';
import '../models/shift.dart';

class CalendarScreen extends StatefulWidget {
  static const String routeName = 'calendarScreen';

  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final DateTime currentDay = DateTime.now();

  @override
  void initState() {
    Provider.of<ShiftProvider>(context, listen: false).checkIfShiftRuns();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Welcome'),
              ],
            ),
            Column(
              children: [
                Text(
                  HelperMethods.currentDayOfWeekAsString(currentDay),
                  style: CustomTextStyles.calendarLetters(),
                ),
                Text(
                  currentDay.day.toString(),
                  style: CustomTextStyles.calendarNumber(),
                ),
                Text(
                  HelperMethods.currentMonthAsString(currentDay),
                  style: CustomTextStyles.calendarLetters(),
                ),
              ],
            ),
            Column(
              children: [
                Consumer<ShiftProvider>(
                  builder: (context, snapshot, child) {
                    if (snapshot.isShiftRunning == false) {
                      return Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: CustomButtonStyles.customButtons(
                                  Colors.green),
                              onPressed: () {
                                _showLoadingDialog(context);
                                _startShift();
                              },
                              child: const Text('Start New Shift'),
                            ),
                          )
                        ],
                      );
                    } else {
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              print('Test');
                            },
                            child: Card(
                              color: Colors.black54,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'Total Rides: ',
                                              style: CustomTextStyles
                                                  .mediumWhite(),
                                            ),
                                            Text(
                                              snapshot.runningShift.totalRides
                                                  .toString(),
                                              style: CustomTextStyles
                                                  .mediumWhite(),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Total BLK: ',
                                              style: CustomTextStyles
                                                  .mediumWhite(),
                                            ),
                                            Text(
                                              '${snapshot.runningShift.totalIncomeBlack} €',
                                              style: CustomTextStyles
                                                  .mediumWhite(),
                                            )
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: CustomButtonStyles.customButtons(
                                      Colors.blue),
                                  onPressed: () {
                                    _showAddRideDialog(context);
                                  },
                                  child: const Text('Add Ride'),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: ElevatedButton(
                                  style: CustomButtonStyles.customButtons(
                                    Colors.red,
                                  ),
                                  onPressed: () {
                                    _showEndShiftDialog(context, snapshot);
                                  },
                                  child: const Text('End Shift'),
                                ),
                              ),
                            ],
                          )
                        ],
                      );
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: CustomButtonStyles.customButtons(Colors.orange),
                        child: Text(
                          'Add New Expense',
                        ),
                      ),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _startShift() {
    Provider.of<ShiftProvider>(context, listen: false)
        .createShift(DateTime.now())
        .then((value) {
      _dismissLoadingDialog(context);
    });
  }

  void _showLoadingDialog(BuildContext context) {
    AlertDialog loadingAlertDialog = const AlertDialog(
      content: Row(
        children: [
          CircularProgressIndicator(),
          SizedBox(width: 10),
          Text('Loading...'),
        ],
      ),
    );

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => loadingAlertDialog);
  }

  void _dismissLoadingDialog(BuildContext context) {
    Navigator.pop(context);
  }

  void _showEndShiftDialog(BuildContext context, ShiftProvider provider) {
    AlertDialog endShiftDialog = AlertDialog(
      surfaceTintColor: Colors.white,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('Are you sure to end the active shift?'),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);

                    showDialog(
                      context: context,
                      builder: (context) => EndShiftDialog(),
                    );
                  },
                  child: const Text('Yes')),
              SizedBox(
                width: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('No')),
            ],
          ),
        ],
      ),
    );

    showDialog(context: context, builder: (context) => endShiftDialog);
  }

  void _showShiftReportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => ShortShiftReportDialog(),
    );
  }

  void _showAddRideDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AddNewRideDialog(),
    );
  }
}
