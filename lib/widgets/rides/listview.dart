import 'package:cab_economics/helpers/caclulations_helper.dart';
import 'package:cab_economics/helpers/helper_methods.dart';
import 'package:cab_economics/models/ride_supplier.dart';
import 'package:cab_economics/providers/ride_provider.dart';
import 'package:cab_economics/providers/ride_supplier_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RidesListView extends StatefulWidget {
  final DateTime rideDate;

  const RidesListView(this.rideDate, {super.key});

  @override
  State<RidesListView> createState() => _RidesListViewState();
}

class _RidesListViewState extends State<RidesListView> {
  double commissionAmount = 0.0;
  List<double> commissions = [];

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      List<double> newsCom = [];

      final provider = Provider.of<RideProvider>(context, listen: false);

      await provider.getAllDateRides(widget.rideDate);

      final rideList = provider.rides;

      for (var element in rideList) {

        await Provider.of<RideSupplierProvider>(context, listen: false)
            .getSupplierCommission(element.supplierKey!)
            .then((value) {
              double rideCommissionAmount = CalculationHelper.calculateCommission(
              value, element.taximeterFare! + element.extraCost!);

          newsCom.add(rideCommissionAmount);
        });
      }

      setState(() {
        print('setstate runs');
        commissions = newsCom;
      });




    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RideProvider>(
      builder: (context, snapShot, _) {
        if (snapShot.isLoading == false) {
          if (snapShot.rides.isNotEmpty) {
            return ListView.builder(
              itemCount: snapShot.rides.length,
              itemBuilder: (context, index) {
                final ride = snapShot.rides[index];
                final sumFare = ride.taximeterFare! + ride.extraCost!;
                return ExpansionTile(
                  title: Text(HelperMethods.timeToShow(ride.createdAt!)),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Supplier:'),
                        Text(ride.supplierName!),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Payment Type:'),
                        Text(ride.paymentType!.name),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Ride Type:'),
                        Text(ride.rideType!.name),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Taximeter Fare:'),
                        Text('${ride.taximeterFare!.toString()} €'),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Extra Fare:'),
                        Text('${ride.extraCost!.toString()} €'),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Sum Fare:'),
                        Text('$sumFare €'),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Commission Amount:'),
                        Text(commissions.isNotEmpty
                            ? '${commissions[index]} €'
                            : 'nan'),
                      ],
                    ),
                  ],
                );
              },
            );
          } else {
            return const Center(
              child: Text('No Rides for this date'),
            );
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
