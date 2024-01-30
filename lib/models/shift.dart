import 'package:cab_economics/models/ride.dart';

class Shift {
  DateTime? start;
  DateTime? end;
  int? km;
  double? fuelCost;
  double? fuelLitrePrice;
  double? totalIncomeBlack;
  double? totalIncome;
  double? totalFpa;

  Shift({
    this.start,
    this.end,
    this.km = 0,
    this.fuelCost = 0.0,
    this.fuelLitrePrice = 0.0,
    this.totalIncomeBlack = 0.0,
    this.totalIncome = 0.0,
    this.totalFpa = 0.0,
  });

  Shift.fromJson(Map<dynamic, dynamic> json) {
    start = DateTime.parse(json['start']);
    end = json['end'] == 'waiting...' ? null : DateTime.parse(json['end']);
    km = json['km'];
    fuelLitrePrice = json['fuel_litre_price'] + 0.0;
    fuelCost = json['fuel_cost'] + 0.0;
    totalIncomeBlack = json['total_black'] + 0.0;
    totalIncome = json['total_collection'] + 0.0;
    totalFpa = json['total_fpa'] + 0.0;
  }
}
