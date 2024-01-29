import 'package:flutter/material.dart';

import '../models/ride.dart';

class RidePaymentTypeDropDown extends StatefulWidget {
  final Function(PaymentType) callback;

  const RidePaymentTypeDropDown(this.callback, {super.key});

  @override
  State<RidePaymentTypeDropDown> createState() =>
      _RidePaymentTypeDropDownState();
}

class _RidePaymentTypeDropDownState extends State<RidePaymentTypeDropDown> {
  @override
  void initState() {
    widget.callback(PaymentType.cash);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<PaymentType>(
      initialSelection: PaymentType.cash,
      onSelected: (value) {
        widget.callback(value!);
      },
      dropdownMenuEntries: PaymentType.values
          .map<DropdownMenuEntry<PaymentType>>((PaymentType paymentType) {
        return DropdownMenuEntry(value: paymentType, label: paymentType.name);
      }).toList(),
    );
  }
}
