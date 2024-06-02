import 'package:employee_info/widgets/today_attendance_card.dart';
import 'package:flutter/material.dart';
import 'package:route_transitions/route_transitions.dart';
import '../widgets/custom_grid_view_item.dart';
import 'employees_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Container(),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(61, 100, 145, 1),
      ),
      body: Stack(children: [
        Column(
          children: [
            Container(
              color: const Color.fromRGBO(61, 100, 145, 1),
              height: MediaQuery.of(context).size.height / 4,
            ),
            Expanded(
                child: Container(
              color: Colors.grey.shade50,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, bottom: 20, top: 120),
                child: GridView.count(
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  crossAxisCount: 3,
                  children: [
                    //To ADD: navigate to each item's page
                    CustomGridViewItem(
                      label: 'Attendance',
                      icon: Icons.checklist,
                      color: Colors.yellow,
                      onTap: () {},
                    ),
                    CustomGridViewItem(
                      label: 'Departments',
                      icon: Icons.list,
                      color: Colors.lightBlueAccent,
                      onTap: () {},
                    ),
                    CustomGridViewItem(
                        label: 'Employees',
                        icon: Icons.badge,
                        color: Colors.purple,
                        onTap: () {
                          slideRightWidget(
                              newPage: EmployeesListPage(), context: context);
                        }),
                    CustomGridViewItem(
                      label: 'Projects',
                      icon: Icons.work,
                      color: Colors.pink,
                      onTap: () {},
                    ),
                    CustomGridViewItem(
                      label: 'Salary',
                      icon: Icons.paid,
                      color: Colors.lightGreen,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ))
          ],
        ),

        //logo+slogan over 1st container
        Positioned(
          top: 0,
          left: 140,
          right: 140,
          child: Row(
            children: [
              Image.asset(
                'assets/images/em_white.png',
                height: 55,
              ),
              const SizedBox(
                width: 5,
              ),
              const Text(
                'power Your Workforce!',
                style: TextStyle(
                  fontFamily: 'Pacifico',
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),

        //Card over 2 containers
        const Positioned(
            top: 90, left: 20, right: 20, child: TodayAttendanceCard()),
      ]),
    );
  }
}
