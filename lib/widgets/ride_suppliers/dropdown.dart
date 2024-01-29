import 'package:cab_economics/models/ride_supplier.dart';
import 'package:cab_economics/providers/ride_supplier_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RideSuppliersDropDown extends StatefulWidget {
  final Function(RideSupplier?) callback;

  const RideSuppliersDropDown(this.callback, {super.key});

  @override
  State<RideSuppliersDropDown> createState() => _RideSuppliersDropDownState();
}

class _RideSuppliersDropDownState extends State<RideSuppliersDropDown> {
  @override
  void initState() {
    final provider = Provider.of<RideSupplierProvider>(context, listen: false);
    provider.getAllRideSuppliers();

    RideSupplier initial =
        RideSupplier(name: 'Road', commissionType: CommissionType.none);

    widget.callback(initial);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    late RideSupplier? dropdownValue;

    return Consumer<RideSupplierProvider>(
      builder: (context, snapshot, child) {
        if (snapshot.rideSuppliers.isEmpty) {
          return const CircularProgressIndicator();
        } else {
          return DropdownMenu<RideSupplier?>(
            initialSelection: snapshot.rideSuppliers.first,
            onSelected: (value) {
              // setState(() {
              //   dropdownValue = value;
              // });
              widget.callback(value!);
            },
            dropdownMenuEntries: snapshot.rideSuppliers
                .map<DropdownMenuEntry<RideSupplier>>((RideSupplier supplier) {
              return DropdownMenuEntry(value: supplier, label: supplier.name!);
            }).toList(),
          );
        }
      },
    );
  }
}
