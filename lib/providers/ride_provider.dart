import 'package:cab_economics/helpers/helper_methods.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../models/ride.dart';

class RideProvider extends ChangeNotifier {
  DatabaseReference ref = FirebaseDatabase.instance.ref();

  bool isLoading = false;

  final List<Ride> _rides = [];

  List<Ride> get rides => _rides;

  Future<void> createRide(DateTime shiftStart, Ride data) async {
    isLoading = true;

    Map newRide = {
      'supplierName': data.supplierName,
      'supplierKey': data.supplierKey,
      'taximeterFare': data.taximeterFare,
      'paymentType': data.paymentType!.name.toString(),
      'rideType': data.rideType!.name.toString(),
      'extraCost': data.extraCost,
      'created_at': DateTime.now().toString(),
    };

    ref
        .child(_createDbPathRides(shiftStart))
        .push()
        .set(newRide)
        .then((value) async {
      final snapShot =
          await ref.child(HelperMethods.pathForOneShift(shiftStart)).get();

      if (snapShot.exists) {
        var dataFromDb = snapShot.value as Map;

        double d =
            dataFromDb['total_black'] + data.taximeterFare + data.extraCost;

        ref.child(HelperMethods.pathForOneShift(shiftStart)).update({
          'total_black': double.parse(d.toStringAsFixed(2)),
          'total_rides': dataFromDb['total_rides'] + 1,
        }).then((value) {
          isLoading = false;

          notifyListeners();
        });
      } else {
        isLoading = false;

        notifyListeners();
      }
    });
  }

  Future<void> getAllDateRides(DateTime shiftDate) async {
    isLoading = true;

    notifyListeners();

    final snapShot = await ref.child(_createDbPathRides(shiftDate)).get();

    _rides.clear();

    if (snapShot.exists) {
      final dataFromServer = snapShot.value as Map;

      dataFromServer.forEach((key, value) {
        Ride ride = Ride.fromJson(key, value);
        _rides.add(ride);
      });
    }

    _rides.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));

    isLoading = false;

    notifyListeners();
  }

  String _createDbPathRides(DateTime dateTime) {
    return '${dateTime.year}/rides/${HelperMethods.currentMonthAsString(dateTime)}/key_${dateTime.day}';
  }
}
