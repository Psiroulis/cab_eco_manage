import 'package:cab_economics/models/ride_supplier.dart';
import 'package:cab_economics/providers/ride_provider.dart';

enum PaymentType {
  cash,
  creditCard,
  providerCredit,
}

class Ride {
  RideSupplier supplier;
  double? fare;
  PaymentType paymentType;
  double? extraCost;
  DateTime? createdAt;


  Ride({
    required this.supplier,
    required this.fare,
    required this.paymentType,
    this.extraCost,
    this.createdAt,
  });
}
