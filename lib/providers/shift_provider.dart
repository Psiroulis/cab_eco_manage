import 'dart:async';
import 'package:cab_economics/helpers/helper_methods.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/shift.dart';

class ShiftProvider extends ChangeNotifier {
  final DatabaseReference dbRef = FirebaseDatabase.instance.ref();

  DateTime currentDay = DateTime.now();

  bool? isShiftRunning = false;

  late StreamSubscription<DatabaseEvent> sub1;

  late String runningShiftId;

  Shift runningShift = Shift(start: DateTime.now());

  final List<Shift> _shifts = [];

  List<Shift> get shifts => _shifts;

  void checkIfShiftRuns() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var haveAShiftRunning = prefs.getBool('haveShiftRunning');

    if (haveAShiftRunning != null && haveAShiftRunning == true) {
      isShiftRunning = true;

      runningShiftId = prefs.getString('runningShiftId')!;

      getRunningShiftReport();
    }

    notifyListeners();
  }

  Future<void> createShift(DateTime creationDateTime) async {

    Map newShift = {
      'day_of_week': HelperMethods.currentDayOfWeekAsString(creationDateTime),
      'start': creationDateTime.toString(),
      'end': 'waiting...',
      'km': 0,
      'total_collection': 0,
      'total_fpa': 0,
      'total_black': 0,
      'fuel_litre_price': 0,
      'fuel_cost': 0,
    };

    dbRef.child(HelperMethods.pathForOneShift(creationDateTime)).set(newShift).then((value) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setBool('haveShiftRunning', true);

      await prefs.setString('runningShiftId', creationDateTime.day.toString());

      isShiftRunning = true;

      runningShiftId = creationDateTime.day.toString();

      getRunningShiftReport();

      notifyListeners();
    });
  }

  Future<void> endShift(Shift shift) async {
    await sub1.cancel();

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, Object?> updatedData = {
      'end': DateTime.now().toString(),
      'total_collection': shift.totalIncome,
      'total_fpa': shift.totalFpa,
      'fuel_litre_price': shift.fuelLitrePrice,
      'fuel_cost': shift.fuelCost,
      'km': shift.km,
    };

    dbRef
        .child(HelperMethods.pathForOneShift(runningShift.start!))
        .update(updatedData)
        .then((value) async {
      await prefs.clear();

      isShiftRunning = false;

      notifyListeners();
    });
  }

  void getRunningShiftReport() async {
    sub1 = FirebaseDatabase.instance
        .ref(
            '${currentDay.year.toString()}/shifts/${HelperMethods.currentMonthAsString(currentDay)}/$runningShiftId')
        .onValue
        .listen((event) {
      if (event.snapshot.value != null) {
        final data = event.snapshot.value as Map;

        runningShift = Shift.fromJson(data);

        notifyListeners();
      }
    });
  }

  void getAllCurrentMonthShifts() {
    dbRef
        .child(
            '${currentDay.year.toString()}/shifts/${HelperMethods.currentMonthAsString(currentDay)}/')
        .onValue
        .listen((event) {
      if (event.snapshot.exists) {
        print(event.snapshot.value);

        final data = event.snapshot.value as Map;

        _shifts.clear();

        data.forEach((key, value) {
          var shift = Shift.fromJson(value);
          _shifts.add(shift);
        });

        _shifts.sort((a, b) => a.start!.compareTo(b.start!));
      } else {
        _shifts.clear();
        print('No Data');
      }

      notifyListeners();
    });
  }

  Future<void> createShiftRetrochronized(Shift shift) async {
    DatabaseReference ref =
        FirebaseDatabase.instance.ref(HelperMethods.pathForOneShift(shift.start!));

    Map newShift = {
      'day_of_week': HelperMethods.currentDayOfWeekAsString(shift.start!),
      'start': shift.start.toString(),
      'end': shift.end.toString(),
      'total_black': shift.totalIncomeBlack,
      'total_collection': shift.totalIncome,
      'total_fpa': shift.totalFpa,
      'km': shift.km == 0 ? 0 : shift.km,
      'fuel_litre_price': shift.fuelLitrePrice == 0 ? 0 : shift.fuelLitrePrice,
      'fuel_cost': shift.fuelCost == 0 ? 0 : shift.fuelCost,
    };

    ref.set(newShift).then((value) async {
      notifyListeners();
    });
  }
}


