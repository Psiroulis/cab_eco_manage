import 'package:cab_economics/models/shift.dart';
import 'package:cab_economics/widgets/rides/listview.dart';
import 'package:flutter/material.dart';

class RideListDialog extends StatefulWidget {
  final Shift shift;

  const RideListDialog(this.shift, {super.key});

  @override
  State<RideListDialog> createState() => _RideListDialogState();
}

class _RideListDialogState extends State<RideListDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: RidesListView(widget.shift.start!),
      ),
    );
  }
}
