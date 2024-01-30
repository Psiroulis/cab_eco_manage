import 'package:cab_economics/providers/shift_provider.dart';
import 'package:cab_economics/widgets/shifts/add_dialog.dart';
import 'package:cab_economics/widgets/shifts/summary_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShiftsScreen extends StatefulWidget {
  const ShiftsScreen({super.key});

  @override
  State<ShiftsScreen> createState() => _ShiftsScreenState();
}

class _ShiftsScreenState extends State<ShiftsScreen> {
  @override
  void initState() {
    final provider = Provider.of<ShiftProvider>(context, listen: false);
    provider.getAllCurrentMonthShifts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shifts'),
      ),
      body: Consumer<ShiftProvider>(
        builder: (context, snapshot, child) {
          if (snapshot.shifts.isEmpty) {
            return const Center(
              child: Text('No shift in current month'),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.shifts.length,
              itemBuilder: (context, index) =>
                  ShiftSummaryCard(snapshot.shifts[index]),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const AddShiftDialog(),
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
