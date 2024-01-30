import 'package:cab_economics/models/ride_supplier.dart';
import 'package:cab_economics/providers/ride_provider.dart';

enum PaymentType {
  cash,
  creditCard,
  supplierCredit,
}

enum RideType {
  none,
  call,
  appointment,
}

class Ride {
  String? key;
  String? supplierKey;
  String? supplierName;
  double? taximeterFare;
  PaymentType? paymentType;
  RideType? rideType;
  double? extraCost;
  DateTime? createdAt;

  Ride({
    this.key,
    this.supplierName,
    this.supplierKey,
    required this.taximeterFare,
    required this.paymentType,
    this.rideType,
    this.extraCost,
    this.createdAt,
  });

  Ride.fromJson(String keyFromApi, Map<dynamic, dynamic> json) {
    key = keyFromApi;
    supplierName = json['supplierName'];
    supplierKey = json['supplierKey'];
    taximeterFare = json['taximeterFare'];

    if (json['paymentType'] == PaymentType.cash.toString()) {
      paymentType = PaymentType.cash;
    } else if (json['paymentType'] == PaymentType.creditCard.toString()) {
      paymentType = PaymentType.creditCard;
    } else {
      paymentType = PaymentType.supplierCredit;
    }

    if (json['rideType'] == RideType.none) {
      rideType = RideType.none;
    } else if (json['rideType'] == RideType.call) {
      rideType = RideType.call;
    } else {
      rideType = RideType.appointment;
    }

    extraCost = json['extraCost'] + 0.0;
  }
}
