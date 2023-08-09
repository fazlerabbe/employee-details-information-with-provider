import 'package:datepicker_employee/employeeModel.dart';
import 'package:flutter/cupertino.dart';

class EmployeeProvider extends ChangeNotifier {
  List<EmployeeModel> employees = [];
  addEmployee(EmployeeModel employeeModel) {
    employees.add(employeeModel);
    notifyListeners();
  }

  getAllEmployee() {
    employees = employeeList;
    notifyListeners();
  }

  deleteEmployee(EmployeeModel employeeModel) {
    employees.remove(employeeModel);
    notifyListeners();
  }

  updateFavorite(int index) {
    employees[index].favorite = !employees[index].favorite;
    notifyListeners();
  }
}
