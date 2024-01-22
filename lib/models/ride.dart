enum PaymentType {
  cash,
  creditCard,
  providerCredit,
}

class Ride {
  String? providerId;
  double? fare;
  PaymentType paymentType;
  DateTime? createdAt;

  Ride({
    this.providerId = '',
    this.fare = 0.0,
    this.paymentType = PaymentType.cash,
    this.createdAt,
  });
}
