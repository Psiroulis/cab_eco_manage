enum CommissionType { none, percentage, monthly }

class RideSupplier {
  String? key;
  String? name;
  CommissionType? commissionType;
  double? commission;
  bool? hasExtras;
  double? extraCall;
  double? extraApoint;
  bool? hasSecretFees;

  RideSupplier({
    this.key,
    required this.name,
    this.commissionType = CommissionType.none,
    this.commission = 0.0,
    this.hasExtras = false,
    this.extraCall = 0.0,
    this.extraApoint = 0.0,
    this.hasSecretFees = false,
  });

  RideSupplier.fromJson(String keyFromApi, Map<dynamic, dynamic> json) {
    key = keyFromApi;

    name = json["name"];

    if (json["commissionType"] == CommissionType.none.toString()) {
      commissionType = CommissionType.none;
    } else if (json["commissionType"] == CommissionType.percentage.toString()) {
      commissionType = CommissionType.percentage;
    } else {
      commissionType = CommissionType.monthly;
    }
    commission = json["commission"] + 0.0;

    hasExtras = json['hasExtras'];

    extraCall = json['extraCall'] + 0.0;

    extraApoint = json['extraApoint'] + 0.0;

    hasSecretFees = json['hasSecretFees'];
  }
}
