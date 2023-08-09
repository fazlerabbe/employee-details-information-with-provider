// ignore_for_file: public_member_api_docs, sort_constructors_first
class EmployeeModel {
  int? empId;
  String name;
  String? dob;
  String designation;
  String mobile;
  String email;
  String streetAddress;
  num salary;
  String img;
  String gender;
  bool favorite;
  EmployeeModel(
      {this.empId,
      required this.name,
      this.dob,
      required this.designation,
      required this.mobile,
      required this.email,
      required this.streetAddress,
      required this.salary,
      required this.img,
      required this.gender,
      this.favorite = false});
}

final List<EmployeeModel> employeeList = [
  EmployeeModel(
      name: "Rakib",
      dob: '01/01/1999',
      designation: "manager",
      mobile: '0899986',
      email: "rakib@gmail.com",
      streetAddress: 'dhanmondi 32',
      salary: 50000,
      img:
          '/data/user/0/com.example.datepicker_employee/cache/0a9003da-6316-4a5d-8112-54d403ae4d70/IMG-20230808-WA0005.jpg',
      gender: 'male'),
];
List<String> designationList = [
  'ceo',
  'manager',
  'sales manager',
  'cto',
  'product manager',
  'software engineer'
];
