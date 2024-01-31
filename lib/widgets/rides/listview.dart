import 'package:cab_economics/helpers/caclulations_helper.dart';
import 'package:cab_economics/helpers/helper_methods.dart';
import 'package:cab_economics/providers/ride_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RidesListView extends StatefulWidget {
  final DateTime rideDate;

  const RidesListView(this.rideDate, {super.key});

  @override
  State<RidesListView> createState() => _RidesListViewState();
}

class _RidesListViewState extends State<RidesListView> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      final provider = Provider.of<RideProvider>(context, listen: false);

      provider.getAllDateRides(widget.rideDate);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool cardIsPressed = false;

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
                        Text(' €'),
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
