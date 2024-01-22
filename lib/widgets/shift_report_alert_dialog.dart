import 'package:cab_economics/helpers/CustomTextStyles.dart';
import 'package:cab_economics/helpers/helper_methods.dart';
import 'package:cab_economics/providers/shift_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShortShiftReportDialog extends StatelessWidget {
  const ShortShiftReportDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final ShiftProvider provider =
        Provider.of<ShiftProvider>(context, listen: false);

    return AlertDialog(
      surfaceTintColor: Colors.white,
      content: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Shift Report',
              style: CustomTextStyles.dialogTitleBlack(),
            ),
            const SizedBox(
              height: 20,
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text(
            //       'Start at: ',
            //       style: CustomTextStyles.mediumBlack(context),
            //     ),
            //     Text(
            //       HelperMethods.timeToShow(provider.runningShift.start!),
            //       style: CustomTextStyles.mediumBlack(context),
            //     ),
            //   ],
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Rides:',
                  style: CustomTextStyles.mediumBlack(),
                ),
                Text(
                  provider.runningShift.totalRides.toString(),
                  style: CustomTextStyles.mediumBlack(),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Coll BLK:',
                  style: CustomTextStyles.mediumBlack(),
                ),
                Text(
                  provider.runningShift.totalIncomeBlack.toString(),
                  style: CustomTextStyles.mediumBlack(),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text(
            //       'Total Coll RCP:',
            //       style: CustomTextStyles.mediumBlack(context),
            //     ),
            //     Text(
            //       provider.runningShift.totalIncome.toString(),
            //       style: CustomTextStyles.mediumBlack(context),
            //     ),
            //   ],
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text(
            //       'Total FPA:',
            //       style: CustomTextStyles.mediumBlack(context),
            //     ),
            //     Text(
            //       provider.runningShift.totalFpa.toString(),
            //       style: CustomTextStyles.mediumBlack(context),
            //     ),
            //   ],
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total WT:',
                  style: CustomTextStyles.mediumBlack(),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  HelperMethods.differenceToShow(
                    DateTime.now().difference(provider.runningShift.start!),
                  ),
                  style: CustomTextStyles.mediumBlack(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
