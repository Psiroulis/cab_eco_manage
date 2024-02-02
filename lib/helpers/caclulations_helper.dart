import 'package:cab_economics/models/ride_supplier.dart';

class CalculationHelper {
  static double calculateCommission(double commission, double fare) {
    print('calculation helper${(fare * commission) / 100}');

    return (fare * commission) / 100;
  }
}
