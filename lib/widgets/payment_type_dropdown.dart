import 'package:flutter/material.dart';

import '../models/ride.dart';

class RidePaymentTypeDropDown extends StatefulWidget {
  final Function(PaymentType) selectPaymentTypeCallback;

  const RidePaymentTypeDropDown(this.selectPaymentTypeCallback, {super.key});

  @override
  State<RidePaymentTypeDropDown> createState() =>
      _RidePaymentTypeDropDownState();
}

class _RidePaymentTypeDropDownState extends State<RidePaymentTypeDropDown> {
  @override
  Widget build(BuildContext context) {
    return DropdownMenu<PaymentType>(
      initialSelection: PaymentType.cash,
      onSelected: (value) {
        widget.selectPaymentTypeCallback(value!);
      },
      dropdownMenuEntries: PaymentType.values
          .map<DropdownMenuEntry<PaymentType>>((PaymentType paymentType) {
        return DropdownMenuEntry(value: paymentType, label: paymentType.name);
      }).toList(),
    );
  }
}
