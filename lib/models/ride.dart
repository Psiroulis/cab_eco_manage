enum PaymentType {
  cash,
  creditCard,
  supplierCredit,
}

enum RideType {
  none,
  call,
  appointment,
  fixed,
  fixedWithFees,
}

class Ride {
  String? key;
  String? supplierKey;
  String? supplierName;
  double? taximeterFare;
  PaymentType? paymentType;
  RideType? rideType;
  double? extraCost;
  double? fee;
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
    taximeterFare = json['taximeterFare'] + 0.0;

    if (json['paymentType'] == PaymentType.cash.name) {
      paymentType = PaymentType.cash;
    } else if (json['paymentType'] == PaymentType.creditCard.name) {
      paymentType = PaymentType.creditCard;
    } else {
      paymentType = PaymentType.supplierCredit;
    }

    if (json['rideType'] == RideType.none.name) {
      rideType = RideType.none;
    } else if (json['rideType'] == RideType.call.name) {
      rideType = RideType.call;
    } else {
      rideType = RideType.appointment;
    }

    extraCost = json['extraCost'] + 0.0;
    fee = json['fee'] == null ? 0 :  json['fee'] + 0.0;
    createdAt = DateTime.parse(json['created_at']);
  }
}
