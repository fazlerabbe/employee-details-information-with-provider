import 'dart:io';

import 'package:datepicker_employee/employeeModel.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EmployeeDetaisPage extends StatefulWidget {
  static const String routeName = '/employee_details';
  const EmployeeDetaisPage({super.key});

  @override
  State<EmployeeDetaisPage> createState() => _EmployeeDetaisPageState();
}

class _EmployeeDetaisPageState extends State<EmployeeDetaisPage> {
  late EmployeeModel employee;
  @override
  void didChangeDependencies() {
    employee = ModalRoute.of(context)!.settings.arguments as EmployeeModel;
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(employee.name),
      ),
      body: ListView(
        children: [
          Image.file(File(employee.img)),
          ListTile(
            title: Text(employee.mobile),
            trailing: IconButton(
              icon: Icon(Icons.call),
              onPressed: _callEmployee,
            ),
          ),
          ListTile(
            title: Text(employee.email),
            trailing: IconButton(
              icon: Icon(Icons.email),
              onPressed: (() {}),
            ),
          ),
          ListTile(
            title: Text(employee.streetAddress),
            trailing: IconButton(
              icon: Icon(Icons.map_outlined),
              onPressed: (() {}),
            ),
          ),
          ListTile(
            title: Text(employee.designation),
            trailing: IconButton(
              icon: Text("BDT ${employee.salary}"),
              onPressed: (() {}),
            ),
          ),
        ],
      ),
    );
  }

  void _callEmployee() async {
    final uri = Uri.parse('tel:${employee.mobile}');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'could not launch url';
    }
  }
}
