import 'package:cab_economics/models/ride.dart';
import 'package:cab_economics/models/ride_supplier.dart';
import 'package:cab_economics/providers/ride_provider.dart';
import 'package:cab_economics/widgets/payment_type_dropdown.dart';
import 'package:cab_economics/widgets/ride_suppliers/dropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../helpers/CustomButtonStyles.dart';

class AddNewRideDialog extends StatefulWidget {
  const AddNewRideDialog({super.key});

  @override
  State<AddNewRideDialog> createState() => _AddNewRideDialogState();
}

class _AddNewRideDialogState extends State<AddNewRideDialog> {
  RideSupplier? _rideSupplier;
  late PaymentType _paymentType;

  callback(RideSupplier? supplier) {
    _rideSupplier = supplier;
  }

  callbackForPaymentType(PaymentType paymentType) {
    _paymentType = paymentType;
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RideProvider>(context, listen: false);

    final TextEditingController _edtAmountConntroler = TextEditingController();

    return Dialog.fullscreen(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Add new ride'),
            Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Fare Amount: '),
                      SizedBox(
                        width: 100,
                        child: TextFormField(
                          controller: _edtAmountConntroler,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '* Required';
                            }
                            return null;
                          },
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
                      const Text('Supplier: '),
                      RideSuppliersDropDown(callback),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Payment type:'),
                      RidePaymentTypeDropDown(callbackForPaymentType)
                    ],
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: CustomButtonStyles.customButtons(Colors.green),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {

                        Navigator.pop(context);

                        Ride newRide = Ride(
                            supplier: _rideSupplier!,
                            fare: double.parse(_edtAmountConntroler.text),
                            paymentType: _paymentType);

                        provider.createRide(DateTime.now(), newRide);
                      }
                    },
                    child: const Text('Add ride to shift'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
