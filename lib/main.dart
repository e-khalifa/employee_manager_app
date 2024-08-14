import 'package:device_preview/device_preview.dart';
import 'package:employee_info/pages/splash_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'sql_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    var sqlHelper = SqlHelper();
    await sqlHelper.initDb();
    GetIt.I.registerSingleton<SqlHelper>(sqlHelper);
  } catch (e) {
    print('Error initializing database: $e');
  }

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const EmployeeManagerApp(),
    ),
  );
}

class EmployeeManagerApp extends StatelessWidget {
  const EmployeeManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Employee Manager',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromRGBO(61, 100, 145, 1),
          foregroundColor: Colors.white,
        ),
      ),
      home: SplashScreen(),
    );
  }
}
