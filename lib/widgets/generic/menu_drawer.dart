import 'package:cab_economics/screens/ride_suppliers_screen.dart';
import 'package:cab_economics/screens/shifts_screen.dart';
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
              color: Colors.amberAccent,
            ),
            child: Text('Menu'),
          ),
          ListTile(
              leading: const Icon(Icons.work_history),
              title: const Text('Shifts'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ShiftsScreen(),
                  ),
                );
              }),
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
