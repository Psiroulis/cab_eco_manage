import 'package:cab_economics/screens/ride_suppliers_screen.dart';
import 'package:cab_economics/screens/shifts/add_new_shift_screen.dart';
import 'package:flutter/material.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.yellow,
            ),
            child: Text('Menu'),
          ),
          ExpansionTile(
            title: const Text('Shifts'),
            leading: const Icon(Icons.work_history),
            childrenPadding: const EdgeInsets.only(left: 30),
            children: [
              ListTile(
                leading: const Icon(Icons.add),
                title: const Text('Add new Shift'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddNewShiftScreen(),
                      ));
                },
              )
            ],
          ),
          ListTile(
            leading: const Icon(Icons.handshake),
            title: const Text('Ride Suppliers'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RideProvidersScreen(),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
