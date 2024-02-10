import 'package:cab_economics/helpers/CustomButtonStyles.dart';
import 'package:cab_economics/helpers/CustomTextStyles.dart';
import 'package:cab_economics/models/ride_supplier.dart';
import 'package:cab_economics/providers/ride_supplier_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddRideSupplierDialog extends StatefulWidget {
  const AddRideSupplierDialog({super.key});

  @override
  State<AddRideSupplierDialog> createState() => _AddRideSupplierDialogState();
}

class _AddRideSupplierDialogState extends State<AddRideSupplierDialog> {
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
                'Add New Ride Supplier',
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
                                        _commissionType = CommissionType.monthly;
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

                          if (_hasCommission) {
                            supplier.commissionType = _commissionType;

                            supplier.commission =
                                double.tryParse(_tecCommission.text);
                          }

                          if (_hasExtras) {
                            supplier.hasExtras = true;
                            supplier.extraCall =
                                double.tryParse(_tecCallExtra.text);
                            supplier.extraAppoint =
                                double.tryParse(_tecAppointmentExtra.text);
                          }

                          if (_hasSecretFees) {
                            supplier.hasSecretFees = true;
                          }

                          final provider = Provider.of<RideSupplierProvider>(
                              context,
                              listen: false);
                          provider.createRideSupplier(supplier);

                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Add')),
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
