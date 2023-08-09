import 'package:datepicker_employee/page/employee_details.dart';
import 'package:datepicker_employee/page/employee_list_page.dart';
import 'package:datepicker_employee/page/new_employee.dart';
import 'package:datepicker_employee/providers/employee_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => EmployeeProvider()..getAllEmployee(),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: EmployeeListPage.routeName,
      routes: {
        EmployeeListPage.routeName: (context) => EmployeeListPage(),
        EmployeeDetaisPage.routeName: (context) => EmployeeDetaisPage(),
        NewEmployee.routeName: (context) => NewEmployee()
      },
    );
  }
}
