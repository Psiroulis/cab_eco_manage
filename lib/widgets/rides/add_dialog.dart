import 'package:cab_economics/models/ride.dart';
import 'package:cab_economics/models/ride_supplier.dart';
import 'package:cab_economics/providers/ride_provider.dart';
import 'package:cab_economics/widgets/payment_type_dropdown.dart';
import 'package:cab_economics/widgets/ride_suppliers/dropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddRideDialog extends StatefulWidget {
  final DateTime shiftStart;

  const AddRideDialog(this.shiftStart, {super.key});

  @override
  State<AddRideDialog> createState() => _AddRideDialogState();
}

class _AddRideDialogState extends State<AddRideDialog> {
  final _formKey = GlobalKey<FormState>();

  bool _supplierHasExtras = false;
  bool _supplierHasSecretFees = false;
  double? _callExtra = 0;
  double? _appointExtra = 0;
  RideType? _rideType = RideType.none;
  RideSupplier _rideSupplier = RideSupplier(name: 'Road');
  PaymentType _paymentType = PaymentType.cash;

  final TextEditingController _tecAmount = TextEditingController();
  final TextEditingController _tecCustomAmount = TextEditingController();
  final TextEditingController _tecCustomFee = TextEditingController();

  bool _supplierDropdownFirstBuild = true;

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      child: Consumer<RideProvider>(
        builder: (context, snapShot, child) {
          if (snapShot.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Text('Add Ride'),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Taximeter Amount:'),
                          SizedBox(
                            width: 100,
                            child: TextFormField(
                              controller: _tecAmount,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return '* Required';
                                }

                                return null;
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Supplier:'),
                          child!,
                        ],
                      ),
                      if (_supplierHasExtras && !_supplierHasSecretFees)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: ListTile(
                                title: Text('Call + $_callExtra'),
                                leading: Radio<RideType>(
                                  value: RideType.call,
                                  groupValue: _rideType,
                                  onChanged: (RideType? value) {
                                    setState(() {
                                      _rideType = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              child: ListTile(
                                title: Text('Appointment + $_appointExtra'),
                                leading: Radio<RideType>(
                                  value: RideType.appointment,
                                  groupValue: _rideType,
                                  onChanged: (RideType? value) {
                                    setState(() {
                                      _rideType = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      if (_supplierHasExtras && _supplierHasSecretFees)
                        Column(
                          children: [
                            ListTile(
                              title: Text('Call + $_callExtra'),
                              leading: Radio<RideType>(
                                value: RideType.call,
                                groupValue: _rideType,
                                onChanged: (RideType? value) {
                                  setState(() {
                                    _rideType = value;
                                  });
                                },
                              ),
                            ),
                            ListTile(
                              title: Text('Appointment + $_appointExtra'),
                              leading: Radio<RideType>(
                                value: RideType.appointment,
                                groupValue: _rideType,
                                onChanged: (RideType? value) {
                                  setState(() {
                                    _rideType = value;
                                  });
                                },
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Radio<RideType>(
                                  value: RideType.fixedWithFees,
                                  groupValue: _rideType,
                                  onChanged: (RideType? value) {
                                    setState(() {
                                      _rideType = value;
                                    });
                                  },
                                ),
                                const Text('Custom'),
                                SizedBox(
                                  width: 100,
                                  child: TextFormField(
                                    controller: _tecCustomAmount,
                                    validator: (value) {
                                      if (_rideType == RideType.fixedWithFees) {
                                        if (value == null || value.isEmpty) {
                                          return '* Required';
                                        }
                                      }

                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                      label: Text('Amount'),
                                      border: OutlineInputBorder(),
                                    ),
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                                SizedBox(
                                  width: 100,
                                  child: TextFormField(
                                    controller: _tecCustomFee,
                                    validator: (value) {
                                      if (_rideType == RideType.fixedWithFees) {
                                        if (value == null || value.isEmpty) {
                                          return '* Required';
                                        }
                                      }

                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                      label: Text('Fee'),
                                      border: OutlineInputBorder(),
                                    ),
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Payment Type:'),
                          RidePaymentTypeDropDown((paymentType) {
                            _paymentType = paymentType;
                          })
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                Ride ride = Ride(
                                  supplierKey: _rideSupplier.key,
                                  supplierName: _rideSupplier.name,
                                  taximeterFare:
                                      double.tryParse(_tecAmount.text),
                                  paymentType: _paymentType,
                                  rideType: _rideType!,
                                );

                                if (_rideType == RideType.none) {
                                  ride.extraCost = 0;
                                } else if (_rideType == RideType.call) {
                                  ride.extraCost = _callExtra;
                                } else if (_rideType == RideType.appointment) {
                                  ride.extraCost = _appointExtra;
                                } else if (_rideType ==
                                    RideType.fixedWithFees) {
                                  ride.taximeterFare =
                                      double.tryParse(_tecCustomAmount.text);
                                  ride.extraCost = 0;
                                  ride.fee =
                                      double.tryParse(_tecCustomFee.text);
                                }

                                Provider.of<RideProvider>(context,
                                        listen: false)
                                    .createRide(widget.shiftStart, ride)
                                    .then((value) => Navigator.pop(context));
                              }
                            },
                            child: const Text('Add'),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Cancel'),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          }
        },
        child: RideSuppliersDropDown((supplier) {
          _rideSupplier = supplier!;
          if (supplier.hasExtras!) {
            setState(() {
              _supplierHasExtras = true;
              if (supplier.hasSecretFees!) {
                _supplierHasSecretFees = true;
              } else {
                _supplierHasSecretFees = false;
              }
              _callExtra = supplier.extraCall;
              _appointExtra = supplier.extraAppoint;
              _rideType = RideType.call;
            });
          } else {
            setState(() {
              _supplierHasExtras = false;
              _supplierHasSecretFees = false;
              _callExtra = 0;
              _appointExtra = 0;
              _rideType = RideType.none;
            });
          }
        }, initiateRideSupplier),
      ),
    );
  }

  void initiateRideSupplier(RideSupplier? supplier) {
    if (_supplierDropdownFirstBuild) {
      _rideSupplier = supplier!;
      _supplierDropdownFirstBuild = false;
    }
  }
}
