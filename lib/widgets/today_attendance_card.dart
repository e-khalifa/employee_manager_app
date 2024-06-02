import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodayAttendanceCard extends StatelessWidget {
  const TodayAttendanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime attendanceDate = DateTime.now();

    return Card(
      elevation: 0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Today\'s Attendance',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: () {
                  //TO ADD: navigate to attendance room
                },
                child: Text(
                  'See All',
                  style: TextStyle(color: Colors.blue.shade700),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                DateFormat('MMM d, yyyy').format(attendanceDate),
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  //TO ADD: navigate to attendance room - filtering present employees
                },
                child: const Column(
                  children: [
                    Text(
                      'Present',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '20',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.green),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  //TO ADD: navigate to attendance room - filtering absent employees
                },
                child: const Column(
                  children: [
                    Text(
                      'Absent',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '10',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.red),
                    )
                  ],
                ),
              )
            ],
          )
        ]),
      ),
    );
  }
}
