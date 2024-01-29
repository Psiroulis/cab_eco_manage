import 'package:cab_economics/helpers/CustomTextStyles.dart';
import 'package:cab_economics/providers/ride_supplier_provider.dart';
import 'package:cab_economics/widgets/ride_suppliers/add_dialog.dart';
import 'package:cab_economics/widgets/ride_suppliers/summary_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RideProvidersScreen extends StatefulWidget {
  static const String routeName = 'rideProviders_screen';

  const RideProvidersScreen({super.key});

  @override
  State<RideProvidersScreen> createState() => _RideProvidersScreenState();
}

class _RideProvidersScreenState extends State<RideProvidersScreen> {
  @override
  void initState() {
    final provider = Provider.of<RideSupplierProvider>(context, listen: false);
    provider.getAllRideSuppliers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ride Suppliers'),
      ),
      body: Consumer<RideSupplierProvider>(
        builder: (context, snapshot, child) {
          if (snapshot.rideSuppliers.isEmpty) {
            return Center(
              child: Text(
                'No ride supplier added yet',
                style: CustomTextStyles.mediumBlackBold(),
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: snapshot.rideSuppliers.length,
                itemBuilder: (context, index) =>
                    RideSupplierSummaryCard(snapshot.rideSuppliers[index]),
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const AddRideSupplierDialog(),
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
