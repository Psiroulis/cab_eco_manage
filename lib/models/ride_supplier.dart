enum CalculateType { percentage, month }

class RideSupplier {
  String? key;
  String? name;
  CalculateType? calculateType;
  int? commission;
  double? costPerMonth;

  RideSupplier({
    this.key,
    required this.name,
    required this.calculateType,
    this.commission = 0,
    this.costPerMonth = 0.0
  });

  RideSupplier.fromJson(String keyFromApi, Map<dynamic, dynamic> json) {
    key = keyFromApi;
    name = json["name"];
    if(json["calculation"] == "percentage"){
      calculateType = CalculateType.percentage;
    }else{
      calculateType = CalculateType.month;
    }
    commission = json["commission"];
    costPerMonth = json["costPerMonth"].toDouble();
  }
}
