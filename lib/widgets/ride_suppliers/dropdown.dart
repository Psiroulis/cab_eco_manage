import 'package:cab_economics/models/ride_supplier.dart';
import 'package:cab_economics/providers/ride_supplier_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RideSuppliersDropDown extends StatefulWidget {
  final Function(RideSupplier?) selectSupplierCallback;
  final Function(RideSupplier?) initiationCallback;

  const RideSuppliersDropDown(
      this.selectSupplierCallback, this.initiationCallback,
      {super.key});

  @override
  State<RideSuppliersDropDown> createState() => _RideSuppliersDropDownState();
}

class _RideSuppliersDropDownState extends State<RideSuppliersDropDown> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      final provider =
          Provider.of<RideSupplierProvider>(context, listen: false);
      provider.getAllRideSuppliers();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RideSupplierProvider>(
      builder: (context, snapshot, child) {
        if (snapshot.rideSuppliers.isEmpty) {
          return const CircularProgressIndicator();
        } else {
          RideSupplier initialSupplier = snapshot.rideSuppliers
              .firstWhere((element) => element.name == "Road");

          widget.initiationCallback(initialSupplier);

          return DropdownMenu<RideSupplier?>(
            initialSelection: initialSupplier,
            onSelected: (value) {
              widget.selectSupplierCallback(value!);
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
