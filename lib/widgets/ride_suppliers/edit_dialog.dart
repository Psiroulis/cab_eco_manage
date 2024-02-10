import 'package:cab_economics/helpers/CustomButtonStyles.dart';
import 'package:cab_economics/helpers/CustomTextStyles.dart';
import 'package:cab_economics/models/ride_supplier.dart';
import 'package:cab_economics/providers/ride_supplier_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditRideSupplierDialog extends StatefulWidget {
  final RideSupplier rideSupplier;

  const EditRideSupplierDialog(this.rideSupplier, {super.key});

  @override
  State<EditRideSupplierDialog> createState() => _EditRideSupplierDialogState();
}

class _EditRideSupplierDialogState extends State<EditRideSupplierDialog> {
  final TextEditingController _tecName = TextEditingController();
  final TextEditingController _tecCommission = TextEditingController();
  late TextEditingController _tecCallExtra;
  late TextEditingController _tecAppointmentExtra;

  final _formKey = GlobalKey<FormState>();

  bool _hasCommission = false;

  CommissionType _commissionType = CommissionType.none;

  bool _payPerMonth = false;
  bool _hasExtras = false;
  bool _hasSecretFees = false;

  @override
  void initState() {
    _tecName.text = widget.rideSupplier.name!;

    if (widget.rideSupplier.commissionType != CommissionType.none) {
      _hasCommission = true;
      _commissionType = widget.rideSupplier.commissionType!;
      if (_commissionType == CommissionType.monthly) {
        _payPerMonth = true;
      }
      _tecCommission.text = widget.rideSupplier.commission.toString();
    }

    if (widget.rideSupplier.hasExtras!) {
      _hasExtras = true;
      _tecCallExtra = TextEditingController();
      _tecAppointmentExtra = TextEditingController();
      _tecCallExtra.text = widget.rideSupplier.extraCall.toString();
      _tecAppointmentExtra.text = widget.rideSupplier.extraAppoint.toString();
    }

    if (widget.rideSupplier.hasSecretFees!) {
      _hasSecretFees = true;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Edit ${widget.rideSupplier.name!} Supplier',
                style: CustomTextStyles.dialogTitleBlack(),
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Supplier Name: ',
                          style: CustomTextStyles.mediumBlack(),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: _tecName,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please provide a name';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Has commission:',
                          style: CustomTextStyles.mediumBlack(),
                        ),
                        Switch(
                            value: _hasCommission,
                            onChanged: (value) {
                              setState(() {
                                _hasCommission = value;

                                if (value) {
                                  _commissionType = CommissionType.percentage;
                                } else {
                                  _commissionType = CommissionType.none;
                                }
                              });
                            })
                      ],
                    ),
                    if (_hasCommission)
                      Column(
                        children: [
                          Text(
                            'Supplier Commission Type',
                            style: CustomTextStyles.mediumBlack(),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '%',
                                      style: CustomTextStyles.mediumBlack(),
                                    ),
                                  ],
                                ),
                              ),
                              Switch(
                                  value: _payPerMonth,
                                  onChanged: (value) {
                                    setState(() {
                                      _payPerMonth = value;

                                      if (value) {
                                        _commissionType =
                                            CommissionType.monthly;
                                      } else {
                                        _commissionType =
                                            CommissionType.percentage;
                                      }
                                    });
                                  }),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Monthly',
                                      style: CustomTextStyles.mediumBlack(),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 200,
                                child: TextFormField(
                                  controller: _tecCommission,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please provide a commission';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      border: const OutlineInputBorder(),
                                      labelText: _payPerMonth
                                          ? 'Monthly fare'
                                          : 'commission %'),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Has Extras:',
                              style: CustomTextStyles.mediumBlack(),
                            ),
                            Switch(
                                value: _hasExtras,
                                onChanged: (value) {
                                  setState(() {
                                    _hasExtras = value;

                                    if (value) {
                                      _tecCallExtra = TextEditingController();
                                      _tecAppointmentExtra =
                                          TextEditingController();
                                    }
                                  });
                                }),
                          ],
                        ),
                        if (_hasExtras)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _tecCallExtra,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please provide an Extra Call Charge';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Call +'),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: _tecAppointmentExtra,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please provide an Extra Appoint Charge';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Appointment +'),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Has Secret Fees:',
                          style: CustomTextStyles.mediumBlack(),
                        ),
                        Switch(
                          value: _hasSecretFees,
                          onChanged: (value) {
                            setState(() {
                              _hasSecretFees = value;
                            });
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: CustomButtonStyles.customButtons(Colors.green),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          RideSupplier supplier =
                              RideSupplier(name: _tecName.text);

                          supplier.key = widget.rideSupplier.key!;

                          if (_hasCommission) {
                            supplier.commissionType = _commissionType;

                            supplier.commission =
                                double.tryParse(_tecCommission.text);
                          } else {
                            supplier.commissionType = CommissionType.none;

                            supplier.commission = 0.0;
                          }

                          if (_hasExtras) {
                            supplier.extraCall =
                                double.tryParse(_tecCallExtra.text);
                            supplier.extraAppoint =
                                double.tryParse(_tecAppointmentExtra.text);
                          } else {
                            supplier.extraCall = 0.0;
                            supplier.extraAppoint = 0.0;
                          }

                          supplier.hasExtras = _hasExtras;
                          supplier.hasSecretFees = _hasSecretFees;

                          final provider = Provider.of<RideSupplierProvider>(
                              context,
                              listen: false);
                          provider.updateRideSupplier(supplier);

                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Save')),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                      style: CustomButtonStyles.customButtons(Colors.red),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
