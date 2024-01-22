import 'package:cab_economics/models/ride_supplier.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class RideSupplierProvider extends ChangeNotifier {
  final DateTime _currentDay = DateTime.now();

  final DatabaseReference dbRef = FirebaseDatabase.instance.ref();

  final List<RideSupplier> _rideSuppliers = [];

  List<RideSupplier> get rideSuppliers => _rideSuppliers;

  bool isLoading = true;

  static const String RIDE_SUPPLIER_PATH = "ride_providers";

  void getAllRideSuppliers() {
     dbRef.child('ride_providers').onValue.listen((event) {

      if(!event.snapshot.exists){
        print('Not existing must handle');
      }else{
        var dataFromServer = event.snapshot.value as Map;
        _rideSuppliers.clear();

        dataFromServer.forEach((key, value) {
          var provider = RideSupplier.fromJson(key,value);
          _rideSuppliers.add(provider);
        });
      }

      isLoading = false;

      notifyListeners();
    });
  }

  void createRideSupplier(RideSupplier rideSupplier) {
    isLoading = true;

    notifyListeners();

    String typeToSend;
    if(rideSupplier.calculateType == CalculateType.percentage){
      typeToSend = "percentage";
    }else{
      typeToSend = "perMonth";
    }

    Map newProvider = {
      'name': rideSupplier.name,
      'commission': rideSupplier.commission,
      'calculation': typeToSend,
      'costPerMonth': rideSupplier.costPerMonth,
      'created_at': _currentDay.toString(),
    };

    dbRef.child(RIDE_SUPPLIER_PATH).push().set(newProvider).then((value) {
      isLoading = false;
      notifyListeners();
    });
  }

  void updateRideSupplier(RideSupplier rideSupplier){

    print('Key income: ${rideSupplier.key}');

    String typeToSend;
    if(rideSupplier.calculateType == CalculateType.percentage){
      typeToSend = "percentage";
    }else{
      typeToSend = "perMonth";
    }

    final postData = {
      'name': rideSupplier.name,
      'commission': rideSupplier.commission,
      'calculation': typeToSend,
      'costPerMonth': rideSupplier.costPerMonth,
      'created_at': _currentDay.toString(),
    };

    dbRef.child('$RIDE_SUPPLIER_PATH/${rideSupplier.key}').update(postData);
  }

  void deleteRideSupplier(int index) {
    String keyToDelete = _rideSuppliers[index].key!;

    dbRef.child('$RIDE_SUPPLIER_PATH/$keyToDelete').remove();
  }


}
