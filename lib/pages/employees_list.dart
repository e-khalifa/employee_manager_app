import 'package:employee_info/pages/employee_adding.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:route_transitions/route_transitions.dart';
import '../models/employee.dart';
import '../sql_helper.dart';

class EmployeesListPage extends StatefulWidget {
  @override
  _EmployeesListPageState createState() => _EmployeesListPageState();
}

class _EmployeesListPageState extends State<EmployeesListPage> {
  List<Employee> _employees = [];
  var sqlHelper = GetIt.I.get<SqlHelper>();

  @override
  void initState() {
    super.initState();
    fetchEmployees();
  }

  void fetchEmployees() async {
    _employees = await sqlHelper.getEmployees();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Company Employees',
            style: TextStyle(color: Colors.white, fontSize: 24)),
        backgroundColor: const Color.fromRGBO(61, 100, 145, 1),
      ),
      body: ListView(children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            headingTextStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(61, 100, 145, 1),
            ),
            dividerThickness: 2,
            columnSpacing: 32,
            columns: const [
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Title')),
              DataColumn(label: Text('Email')),
              DataColumn(label: Text('Phone Number')),
            ],
            rows: _employees.map((employee) {
              return DataRow(
                cells: [
                  DataCell(Text(employee.name)),
                  DataCell(Text(employee.title)),
                  DataCell(Text(employee.email)),
                  DataCell(Text(employee.phone)),
                ],
              );
            }).toList(),
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(61, 100, 145, 1),
        onPressed: () {
          slideUpWidget(newPage: const EmployeeAdding(), context: context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
