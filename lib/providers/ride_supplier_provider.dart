import 'package:cab_economics/models/ride_supplier.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class RideSupplierProvider extends ChangeNotifier {
  final DatabaseReference dbRef = FirebaseDatabase.instance.ref();

  final List<RideSupplier> _rideSuppliers = [];

  List<RideSupplier> get rideSuppliers => _rideSuppliers;

  bool isLoading = true;

  static const String RIDE_SUPPLIER_PATH = "ride_suppliers";

  void getAllRideSuppliers() {
    dbRef.child(RIDE_SUPPLIER_PATH).onValue.listen((event) {
      if (!event.snapshot.exists) {
        _rideSuppliers.clear();
      } else {
        var dataFromServer = event.snapshot.value as Map;

        _rideSuppliers.clear();

        dataFromServer.forEach((key, value) {
          var provider = RideSupplier.fromJson(key, value);
          _rideSuppliers.add(provider);
        });

        _rideSuppliers.sort((a, b) => a.name!.compareTo(b.name!));
      }

      isLoading = false;

      notifyListeners();
    });
  }

  void createRideSupplier(RideSupplier rideSupplier) {
    Map newProvider = {
      'name': rideSupplier.name,
      'commissionType': rideSupplier.commissionType.toString(),
      'commission': rideSupplier.commission,
      'hasExtras': rideSupplier.hasExtras,
      'extraCall': rideSupplier.extraCall,
      'extraApoint': rideSupplier.extraApoint,
      'hasSecretFees': rideSupplier.hasSecretFees,
      'created_at': DateTime.now().toString(),
    };

    dbRef.child(RIDE_SUPPLIER_PATH).push().set(newProvider).then((value) {
      isLoading = false;
      notifyListeners();
    });
  }

  void updateRideSupplier(RideSupplier rideSupplier) {
    print('Key income: ${rideSupplier.key}');

    final postData = {
      'name': rideSupplier.name,
      'commissionType': rideSupplier.commissionType.toString(),
      'commission': rideSupplier.commission,
      'hasExtras': rideSupplier.hasExtras,
      'extraCall': rideSupplier.extraCall,
      'extraApoint': rideSupplier.extraApoint,
      'hasSecretFees': rideSupplier.hasSecretFees,
      'created_at': DateTime.now().toString(),
    };

    dbRef.child('$RIDE_SUPPLIER_PATH/${rideSupplier.key}').update(postData);
  }

  void deleteRideSupplier(String key) {
    // String keyToDelete = _rideSuppliers[index].key!;

    dbRef.child('$RIDE_SUPPLIER_PATH/$key').remove();
  }

  Future<double> getSupplierCommission(String key) async {
    final snapshot = await dbRef.child('$RIDE_SUPPLIER_PATH/$key').get();

    if (snapshot.exists) {
      final data = snapshot.value as Map;

      return data['commission'] + 0.0;
    }

    return 0.0;
  }
}
