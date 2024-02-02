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
  List<RideSupplier> _suppliers = [];

  void getSuppliers() async {
    await Provider.of<RideSupplierProvider>(context, listen: false)
        .getSuppliers()
        .then((value) {
      setState(() {
        _suppliers = value;
      });
    });
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      getSuppliers();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('supplier dropdown builds');
    if (_suppliers.isEmpty) {
      print('supplier dropdown builds 1');
      return const CircularProgressIndicator();
    } else {
      RideSupplier initial =
          _suppliers.where((element) => element.name == 'Road').first;

      print('supplier dropdown builds 2');
      widget.initiationCallback(initial);

      return DropdownMenu<RideSupplier?>(
        initialSelection: initial,
        onSelected: (value) {
          widget.selectSupplierCallback(value!);
        },
        dropdownMenuEntries: _suppliers
            .map<DropdownMenuEntry<RideSupplier>>((RideSupplier supplier) {
          return DropdownMenuEntry(value: supplier, label: supplier.name!);
        }).toList(),
      );
    }
  }
}
