import 'package:cab_economics/models/ride_supplier.dart';
import 'package:cab_economics/providers/ride_supplier_provider.dart';
import 'package:cab_economics/widgets/edit_remove_listview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RideProvidersScreen extends StatefulWidget {
  static const String routeName = 'rideProviders_screen';

  const RideProvidersScreen({super.key});

  @override
  State<RideProvidersScreen> createState() => _RideProvidersScreenState();
}

class _RideProvidersScreenState extends State<RideProvidersScreen> {
  final TextEditingController _edtNameController = TextEditingController();
  final TextEditingController _edtCommisionController = TextEditingController();
  final TextEditingController _edtCostPerMonthController =
      TextEditingController();

  bool calculatePerMonth = false;

  String calculateTitle = "Calculate by % fare";

  final _formKey = GlobalKey<FormState>();

  _resetShowEditDialog() {
    setState(() {
      calculatePerMonth = false;
      calculateTitle = "Calculate by % fare";
    });
    _edtCommisionController.clear();
    _edtCostPerMonthController.clear();
    _edtNameController.clear();
  }

  _setInitialFormValues(RideSupplier rideSupplier) {
    _edtNameController.text = rideSupplier.name!;
    _edtCommisionController.text = rideSupplier.commission.toString();
    _edtCostPerMonthController.text = rideSupplier.costPerMonth.toString();

    if (rideSupplier.calculateType == CalculateType.month) {
      setState(() {
        calculatePerMonth = true;
      });
      _edtCostPerMonthController.text = rideSupplier.costPerMonth.toString();
    } else {
      setState(() {
        calculatePerMonth = false;
      });
    }
  }

  _showAddNewDialog(bool? isForUpdate, RideSupplier? supplierForUpdate) {
    if (isForUpdate!) {
      _setInitialFormValues(supplierForUpdate!);
    }

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            surfaceTintColor: Colors.white,
            content: StatefulBuilder(
              builder: (context, setState) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: _edtNameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please provide a name';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Supplier Name'),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(calculateTitle),
                            Switch(
                                value: calculatePerMonth,
                                onChanged: (value) {
                                  setState(() {
                                    calculatePerMonth = value;
                                    if (value) {
                                      calculateTitle = "Calculate by fixed fare";
                                    } else {
                                      calculateTitle = "Calculate by % fare";
                                    }
                                  });
                                }),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        if (calculatePerMonth)
                          TextFormField(
                            controller: _edtCostPerMonthController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please provide a fee';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Monthly Fixed Fare'),
                          )
                        else
                          TextFormField(
                            controller: _edtCommisionController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please provide a commission';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Commission rate'),
                          ),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              RideSupplier rideSupplier;

                              if (calculatePerMonth) {
                                rideSupplier = RideSupplier(
                                  name: _edtNameController.text,
                                  calculateType: CalculateType.month,
                                  commission: 0,
                                  costPerMonth: double.parse(
                                      _edtCostPerMonthController.text),
                                );
                              } else {
                                rideSupplier = RideSupplier(
                                  name: _edtNameController.text,
                                  calculateType: CalculateType.percentage,
                                  commission:
                                      int.parse(_edtCommisionController.text),
                                  costPerMonth: 0.0,
                                );
                              }

                              final provider = Provider.of<RideSupplierProvider>(
                                context,
                                listen: false,
                              );

                              if (isForUpdate) {
                                rideSupplier.key = supplierForUpdate!.key;
                                provider.updateRideSupplier(rideSupplier);
                              } else {
                                provider.createRideSupplier(rideSupplier);
                              }

                              _resetShowEditDialog();

                              Navigator.pop(context);
                            }
                          },
                          child: Text(isForUpdate! ? "Save" : "Submit"),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        });
  }

  _showDeleteDialog(String name, int index) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            surfaceTintColor: Colors.white,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Are you sure you want to delete $name ride supplier?'),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          final provider = Provider.of<RideSupplierProvider>(
                            context,
                            listen: false,
                          );

                          provider.deleteRideSupplier(index);

                          Navigator.pop(context);
                        },
                        child: Text("Yes")),
                    SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("No")),
                  ],
                )
              ],
            ),
          );
        });
  }

  @override
  void initState() {
    final provider = Provider.of<RideSupplierProvider>(context, listen: false);
    provider.getAllRideSuppliers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('build called');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ride Suppliers'),
      ),
      body: EditRemoveButtonListTile(
        onAddNewOrEditTap: _showAddNewDialog,
        onDeleteTap: _showDeleteDialog,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _resetShowEditDialog();

          _showAddNewDialog(false, null);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
