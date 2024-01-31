import 'package:cab_economics/providers/ride_supplier_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CalculationHelper {

  static Future<double> calculateCommission(
      BuildContext context, String supplierKey, double fare) async {

    double result = 24.0;

    final provider = Provider.of<RideSupplierProvider>(context, listen: false);

    await provider.getSupplierCommission(supplierKey).then((commission) {
      result = (fare * commission) / 100;
    });

    return result;
  }
}
