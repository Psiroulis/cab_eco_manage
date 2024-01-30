import 'package:cab_economics/models/ride_supplier.dart';
import 'package:cab_economics/providers/ride_supplier_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RideSuppliersDropDown extends StatefulWidget {
  final Function(RideSupplier?) selectSupplierCallback;

  const RideSuppliersDropDown(this.selectSupplierCallback, {super.key});

  @override
  State<RideSuppliersDropDown> createState() => _RideSuppliersDropDownState();
}

class _RideSuppliersDropDownState extends State<RideSuppliersDropDown> {
  @override
  void initState() {
    final provider = Provider.of<RideSupplierProvider>(context, listen: false);
    provider.getAllRideSuppliers();
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
