import 'package:cab_economics/helpers/CustomButtonStyles.dart';
import 'package:cab_economics/helpers/CustomTextStyles.dart';
import 'package:cab_economics/models/ride_supplier.dart';
import 'package:cab_economics/providers/ride_supplier_provider.dart';
import 'package:cab_economics/widgets/generic/yes_no_button_dialog.dart';
import 'package:cab_economics/widgets/ride_suppliers/edit_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RideSupplierSummaryCard extends StatefulWidget {
  final RideSupplier rideSupplier;

  const RideSupplierSummaryCard(this.rideSupplier, {super.key});

  @override
  State<RideSupplierSummaryCard> createState() =>
      _RideSupplierSummaryCardState();
}

class _RideSupplierSummaryCardState extends State<RideSupplierSummaryCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              widget.rideSupplier.name!,
              style: CustomTextStyles.dialogTitleBlack(),
            ),
            const SizedBox(
              height: 10,
            ),
            if (widget.rideSupplier.commissionType! != CommissionType.none)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Commission Type: '),
                  Text(widget.rideSupplier.commissionType!.name)
                ],
              ),
            if (widget.rideSupplier.commissionType! != CommissionType.none)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Commission: '),
                  Text(widget.rideSupplier.commission.toString())
                ],
              ),
            if (widget.rideSupplier.hasExtras!)
              const SizedBox(
                height: 10,
              ),
            if (widget.rideSupplier.hasExtras!)
              Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Call:'),
                        Text(widget.rideSupplier.extraCall.toString()),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Appointment:'),
                        Text(widget.rideSupplier.extraAppoint.toString()),
                      ],
                    ),
                  ),
                ],
              ),
            if (widget.rideSupplier.hasSecretFees!)
              const SizedBox(
                height: 10,
              ),
            if (widget.rideSupplier.hasSecretFees!)
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Has Secret Fees'),
                ],
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: CustomButtonStyles.customButtons(Colors.blue),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) =>
                              EditRideSupplierDialog(widget.rideSupplier));
                    },
                    child: const Text('Edit'),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: ElevatedButton(
                    style: CustomButtonStyles.customButtons(Colors.red),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => YesNoButtonsDialog(
                          message:
                              'Do you want to remove${widget.rideSupplier.name} supplier ?',
                          yesCallback: () {
                            _removeSupplier(context, widget.rideSupplier.key!);
                          },
                          noCallback: () {
                            Navigator.pop(context);
                          },
                        ),
                      );
                    },
                    child: const Text('Remove'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

void _removeSupplier(BuildContext context, String key) {
  Provider.of<RideSupplierProvider>(context, listen: false)
      .deleteRideSupplier(key);
}
