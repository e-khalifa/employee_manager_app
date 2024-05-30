import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'pages/employees_list.dart';
import 'pages/home.dart';
import 'sql_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var sqlHelper = SqlHelper();
  await sqlHelper.initDb();
  if (sqlHelper.db != null) {
    GetIt.I.registerSingleton<SqlHelper>(sqlHelper);
  }
  runApp(EmployeeManagerApp());
}

class EmployeeManagerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Employee Manager',
      home: HomePage(),
      routes: {
        '/home': (context) => HomePage(),
        '/employeeList': (context) => EmployeesListPage(),
      },
    );
  }
}
