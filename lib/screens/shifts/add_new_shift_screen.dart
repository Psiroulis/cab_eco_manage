import 'package:flutter/material.dart';

class AddNewShiftScreen extends StatefulWidget {
  static const String routeName = 'addNewShiftScreen';

  const AddNewShiftScreen({super.key});

  @override
  State<AddNewShiftScreen> createState() => _AddNewShiftScreenState();
}

class _AddNewShiftScreenState extends State<AddNewShiftScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new Shift'),
      ),
      body: Center(
        child: Text('Add new Shift'),
      ),
    );
  }
}
