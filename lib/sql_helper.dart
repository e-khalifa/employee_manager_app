import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'models/employee.dart';

class SqlHelper {
  Database? db;

  // Creating database
  Future<void> initDb() async {
    try {
      if (kIsWeb) {
        var factory = databaseFactoryFfiWeb;
        db = await factory.openDatabase('employeemanger.db');
        print('Database creation done web!');
        await createTables();
      } else {
        db = await openDatabase(
          'employeemanger.db',
          version: 1,
          onCreate: (db, version) async {
            print('Database creation done!');
            await createTables();
          },
        );
      }
    } catch (e) {
      print('Error creating database: $e');
    }
  }

  /* Creating tables:
                     1- Employees
                     2- Projects
                     3- Departments
                     4- Employees Attendance
                     5- Salary*/
  Future<bool> createTables() async {
    try {
      var batch = db!.batch();

      // Employees table
      batch.execute('''
        CREATE TABLE IF NOT EXISTS employee(
          id INTEGER PRIMARY KEY,
          name TEXT NOT NULL,
          title TEXT NOT NULL,
          email TEXT NOT NULL,
          phone TEXT NOT NULL,
          departmentId INTEGER,
          salaryId INTEGER,
          FOREIGN KEY (departmentId) REFERENCES department(id),
          FOREIGN KEY (salaryId) REFERENCES salary(id)
        )
      ''');
      print('Employee table created.');

      // Department table
      batch.execute('''
        CREATE TABLE IF NOT EXISTS department(
          id INTEGER PRIMARY KEY,
          name TEXT NOT NULL,
          employees_number INTEGER NOT NULL
        )
      ''');
      print('Department table created.');

      // Project table
      batch.execute('''
        CREATE TABLE IF NOT EXISTS project(
          id INTEGER PRIMARY KEY,
          name TEXT NOT NULL,
          startdate TEXT NOT NULL,
          enddate TEXT NOT NULL,
          employeeId INTEGER,
          FOREIGN KEY (employeeId) REFERENCES employee(id)
        )
      ''');
      print('Project table created.');

      // EmployeeAttendance table
      batch.execute('''
        CREATE TABLE IF NOT EXISTS employeeAttendance(
          id INTEGER PRIMARY KEY,
          attendance_date TEXT NOT NULL,
          status TEXT NOT NULL,
          employeeId INTEGER,
          FOREIGN KEY (employeeId) REFERENCES employee(id)
        )
      ''');
      print('EmployeeAttendance table created.');

      // Salary table
      batch.execute('''
        CREATE TABLE IF NOT EXISTS salary(
          id INTEGER PRIMARY KEY,
          amount INTEGER NOT NULL,
          currency TEXT NOT NULL
        )
      ''');
      print('Salary table created.');

      var result = await batch.commit();
      print('Tables created: $result');
      return true;
    } catch (e) {
      print('Error creating tables: $e');
      return false;
    }
  }

  Future<void> insertEmployee(Employee employee) async {
    try {
      print('Inserting employee: ${employee.toMap()}');
      await db!.insert(
        'employee',
        employee.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print('Adding employee successful!');
    } catch (e) {
      print('Error adding employee: $e');
    }
  }

  Future<List<Employee>> getEmployees() async {
    final List<Map<String, dynamic>> maps = await db!.query('employee');

    return List.generate(maps.length, (i) {
      return Employee(
        id: maps[i]['id'],
        name: maps[i]['name'],
        title: maps[i]['title'],
        email: maps[i]['email'],
        phone: maps[i]['phone'],
      );
    });
  }
}
