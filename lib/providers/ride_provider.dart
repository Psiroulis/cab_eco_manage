import 'package:cab_economics/helpers/helper_methods.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../models/ride.dart';

class RideProvider extends ChangeNotifier {

  void createRide(DateTime shiftStart, Ride data) async {
    DatabaseReference ref =
        FirebaseDatabase.instance.ref(_createDbPathRides(shiftStart));

    Map newRide = {
      'supplierName': data.supplierName,
      'supplierKey': data.supplierKey,
      'taximeterFare': data.taximeterFare,
      'paymentType' : data.paymentType!.name.toString(),
      'rideType' : data.rideType.toString(),
      'extraCost' : data.extraCost,
      'created_at': DateTime.now().toString(),
    };

    ref.push().set(newRide).then((value) => print('Ride Added'));
  }

  String _createDbPathRides(DateTime dateTime) {
    return '${dateTime.year}/shifts/${HelperMethods.currentMonthAsString(dateTime)}/${dateTime.day}/rides';
  }
}
