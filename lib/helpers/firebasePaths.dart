import 'package:cab_economics/helpers/helper_methods.dart';

class FirebasePaths {
  static pathToSaveSupplierInfoPerMonth(
    DateTime dateTime,
    String supplierKey,
  ) {

    String year = dateTime.year.toString();
    String month = HelperMethods.currentMonthAsString(dateTime);
    return '$year/suppliers_report/$month/$supplierKey';

  }
}
