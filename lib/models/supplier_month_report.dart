class SupplierMonthReport {
  int? totalRides;
  double? totalIncome;
  double? extras;
  double? commission;
  double? tips;

  SupplierMonthReport({
    this.totalRides = 0,
    this.totalIncome = 0,
    this.extras = 0,
    this.commission = 0,
    this.tips = 0,
  });

  SupplierMonthReport.fromJson(Map<dynamic,dynamic> json){
    totalRides = json['total_rides'];
    totalIncome = json['total_income'];
    extras = json['total_extras'];
    commission = json['total_commission'];
    tips = json['total_tips'];
  }
}
