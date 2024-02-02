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

  late StreamSubscription<DatabaseEvent> subForShiftList;

  late StreamSubscription<DatabaseEvent> subForShortReport;

  late String runningShiftId;

  Shift runningShift = Shift(start: DateTime.now());

  final List<Shift> _shifts = [];

  List<Shift> get shifts => _shifts;

  bool isLoading = false;

  void checkIfShiftRuns() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var haveAShiftRunning = prefs.getBool('haveShiftRunning');

    if (haveAShiftRunning != null && haveAShiftRunning == true) {
      isShiftRunning = true;

      runningShiftId = prefs.getString('runningShiftId')!;

      var runningShiftDate = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        int.parse(runningShiftId),
      );

      getShortReportForHome(runningShiftDate);

      notifyListeners();
    }
  }

  Future<void> createRunningShift(DateTime creationDateTime) async {
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
      'total_rides': 0,
    };

    dbRef
        .child(HelperMethods.pathForOneShift(creationDateTime))
        .set(newShift)
        .then((value) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setBool('haveShiftRunning', true);

      await prefs.setString('runningShiftId', creationDateTime.day.toString());

      isShiftRunning = true;

      runningShiftId = creationDateTime.day.toString();

      notifyListeners();
    });
  }

  Future<void> endShift(Shift shift) async {
    isLoading = true;

    notifyListeners();

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

      isLoading = false;

      subForShortReport.cancel();

      notifyListeners();
    });
  }

  Future<void> getShortReportForHome(DateTime shiftDate) async {
    subForShortReport = dbRef
        .child(HelperMethods.pathForOneShift(shiftDate))
        .onValue
        .listen((event) {
      if (event.snapshot.exists) {
        final data = event.snapshot.value as Map;

        runningShift.totalRides = data['total_rides'];
        runningShift.totalIncomeBlack = data['total_black'] + 0.0;

        notifyListeners();
      }
    });
  }

  Future<Shift> getShiftReport(DateTime shiftDate) async {
    var snapShot = await FirebaseDatabase.instance
        .ref(HelperMethods.pathForOneShift(shiftDate))
        .get();

    if (snapShot.exists) {
      final mappedData = snapShot.value as Map;

      return Shift.fromJson(mappedData);
    }

    return Shift();
  }

  void getAllCurrentMonthShifts() {
    isLoading = true;

    subForShiftList = dbRef
        .child(
            '${currentDay.year.toString()}/shifts/${HelperMethods.currentMonthAsString(currentDay)}/')
        .onValue
        .listen((event) {
      if (event.snapshot.exists) {
        final data = event.snapshot.value as Map;

        _shifts.clear();

        data.forEach((key, value) {
          var shift = Shift.fromJson(value);
          _shifts.add(shift);
        });

        _shifts.sort((a, b) => a.start!.compareTo(b.start!));
      } else {
        _shifts.clear();
      }

      isLoading = false;

      notifyListeners();
    });
  }

  Future<void> createShiftRetrochronized(Shift shift) async {
    DatabaseReference ref = FirebaseDatabase.instance
        .ref(HelperMethods.pathForOneShift(shift.start!));

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
      'total_rides': shift.totalRides,
    };

    ref.set(newShift).then((value) async {
      notifyListeners();
    });
  }

  void unSubscribe() async {
    await subForShiftList.cancel();
  }
}
