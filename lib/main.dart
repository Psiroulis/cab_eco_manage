import 'package:cab_economics/providers/ride_supplier_provider.dart';
import 'package:cab_economics/providers/shift_provider.dart';
import 'package:cab_economics/screens/calendar_screen.dart';
import 'package:cab_economics/screens/ride_suppliers_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (value) => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<ShiftProvider>(
            create: (_) => ShiftProvider(),
          ),
          ChangeNotifierProvider<RideSupplierProvider>(
              create: (_) => RideSupplierProvider()),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Colors.green, iconSize: 40.0),
        appBarTheme: const AppBarTheme(
          color: Colors.amberAccent,
          titleTextStyle: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: CalendarScreen.routeName,
      routes: {
        CalendarScreen.routeName: (ctx) => const CalendarScreen(),
        RideProvidersScreen.routeName: (ctx) => const RideProvidersScreen(),
      },
    );
  }
}
