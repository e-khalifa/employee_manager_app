import 'package:flutter/material.dart';
import '../models/employee.dart';
import '../sql_helper.dart';

class EmployeesListPage extends StatefulWidget {
  @override
  _EmployeesListPageState createState() => _EmployeesListPageState();
}

class _EmployeesListPageState extends State<EmployeesListPage> {
  List<Employee> _employees = [];
  final sqlHelper = SqlHelper();

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
        title: Text('Company Employees',
            style: TextStyle(color: Colors.white, fontSize: 24)),
        backgroundColor: Colors.blueGrey,
      ),
      body: ListView(children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columnSpacing: 32,
            columns: [
              DataColumn(
                  label: Text('Name',
                      style: TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Title',
                      style: TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Email',
                      style: TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Phone Number',
                      style: TextStyle(fontWeight: FontWeight.bold))),
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
        onPressed: () {
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blueGrey,
      ),
    );
  }
}
