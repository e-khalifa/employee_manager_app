import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../models/employee.dart';
import '../sql_helper.dart';
import '../widgets/custom_text_field.dart';
import 'employees_list.dart';

class EmployeeAdding extends StatefulWidget {
  const EmployeeAdding({super.key});

  @override
  State<EmployeeAdding> createState() => _EmployeeAddingState();
}

class _EmployeeAddingState extends State<EmployeeAdding> {
  var sqlHelper = GetIt.I.get<SqlHelper>();
  final List<Employee> _employees = [];
  Employee? _recentlyAddedEmployee;

  //validation
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final titleController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  //adding employee
  void addEmployee() async {
    Employee newEmployee = Employee(
      name: nameController.text,
      title: titleController.text,
      email: emailController.text,
      phone: phoneController.text,
    );
    //adding in db
    await sqlHelper.insertEmployee(newEmployee);
    setState(() {
      _recentlyAddedEmployee = newEmployee;
      _employees.add(newEmployee);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Manager',
            style: TextStyle(color: Colors.white, fontSize: 24)),
        backgroundColor: const Color.fromRGBO(61, 100, 145, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              customTextField(
                label: 'Employee Name',
                controller: nameController,
              ),
              customTextField(
                label: 'Title',
                controller: titleController,
              ),
              customTextField(
                label: 'Email',
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              customTextField(
                label: 'Phone Number',
                controller: phoneController,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    addEmployee();
                    nameController.clear();
                    titleController.clear();
                    emailController.clear();
                    phoneController.clear();
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                              title: const Text('Employee Added Successfully!'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      if (_recentlyAddedEmployee != null) {
                                        Navigator.of(context).pop();

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  EmployeesListPage()),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content:
                                                Text('No employee added yet.'),
                                            duration: Duration(seconds: 3),
                                          ),
                                        );
                                      }
                                    },
                                    child:
                                        const Text('View Employees Details')),
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Add a New Employee'))
                              ]);
                        });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(61, 100, 145, 1),
                  foregroundColor: Colors.white,
                ),
                child: const Text('Add Employee'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
