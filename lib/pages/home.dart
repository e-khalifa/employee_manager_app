import 'package:flutter/material.dart';
import 'package:employee_info/sql_helper.dart';
import 'package:get_it/get_it.dart';
import '../models/employee.dart';
import '../widgets/custom_text_field.dart';
import 'employees_list.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var sqlHelper = GetIt.I.get<SqlHelper>();
  List<Employee> _employees = [];
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
        title: Text('Employee Manager',
            style: TextStyle(color: Colors.white, fontSize: 24)),
        backgroundColor: Colors.blueGrey,
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
              SizedBox(height: 20),
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
                              title: Text('Employee Added Successfully!'),
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
                                          SnackBar(
                                            content:
                                                Text('No employee added yet.'),
                                            duration: Duration(seconds: 3),
                                          ),
                                        );
                                      }
                                    },
                                    child: Text('View Employees Details')),
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Add a New Employee'))
                              ]);
                        });
                  }
                },
                child: Text('Add Employee'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
