import 'dart:io';

import 'package:datepicker_employee/employeeModel.dart';
import 'package:datepicker_employee/page/employee_details.dart';
import 'package:datepicker_employee/page/new_employee.dart';
import 'package:datepicker_employee/providers/employee_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmployeeListPage extends StatefulWidget {
  static const String routeName = '/';
  const EmployeeListPage({super.key});

  @override
  State<EmployeeListPage> createState() => _EmployeeListPageState();
}

class _EmployeeListPageState extends State<EmployeeListPage> {
  Future<bool?> deleteConfirmationDialog(DismissDirection direction) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("delete"),
        content: const Text("Sure to delete"),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text("cencel")),
          TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: Text("Yes"))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("employee list page"),
      ),
      body: Consumer<EmployeeProvider>(
        builder: (context, provider, child) => ListView.builder(
          itemCount: provider.employees.length,
          itemBuilder: (context, index) {
            final emp = provider.employees[index];
            return Dismissible(
              key: UniqueKey(),
              direction: DismissDirection.endToStart,
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                child: const Icon(
                  Icons.delete,
                  size: 40,
                  color: Colors.white,
                ),
              ),
              confirmDismiss: deleteConfirmationDialog,
              onDismissed: (direction) => provider.deleteEmployee(emp),
              child: ListTile(
                onTap: () => Navigator.pushNamed(
                    context, EmployeeDetaisPage.routeName,
                    arguments: emp),
                leading: CircleAvatar(
                  backgroundImage: FileImage(File(emp.img)),
                ),
                title: Text(emp.name),
                subtitle: Text(emp.designation),
                trailing: IconButton(
                    onPressed: () {
                      provider.updateFavorite(index);
                    },
                    icon: Icon(emp.favorite
                        ? Icons.favorite
                        : Icons.favorite_border_outlined)),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, NewEmployee.routeName),
        child: Icon(Icons.add),
      ),
    );
  }
}
