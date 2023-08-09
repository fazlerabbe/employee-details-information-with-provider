import 'dart:io';

import 'package:datepicker_employee/employeeModel.dart';
import 'package:datepicker_employee/helper_function.dart';
import 'package:datepicker_employee/providers/employee_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class NewEmployee extends StatefulWidget {
  static const String routeName = '/new_employee';
  const NewEmployee({super.key});

  @override
  State<NewEmployee> createState() => _NewEmployeeState();
}

class _NewEmployeeState extends State<NewEmployee> {
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final salaryController = TextEditingController();
  String? dob;

  String? imagePath;
  ImageSource sourse = ImageSource.camera;
  String genderRadioGroup = 'male';
  String? designation;

  @override
  void dispose() {
    nameController.dispose();
    mobileController.dispose();
    emailController.dispose();
    addressController.dispose();
    salaryController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Employee detais page")),
        actions: [IconButton(onPressed: _saveEmployee, icon: Icon(Icons.done))],
      ),
      body: ListView(
        children: [
          TextFormField(
            keyboardType: TextInputType.text,
            controller: nameController,
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.person),
                filled: true,
                labelText: "employee name"),
          ),
          TextFormField(
            keyboardType: TextInputType.phone,
            controller: mobileController,
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.phone),
                filled: true,
                labelText: "phone number"),
          ),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: emailController,
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.email_outlined),
                filled: true,
                labelText: "Enter email"),
          ),
          TextFormField(
            keyboardType: TextInputType.streetAddress,
            controller: addressController,
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.map),
                filled: true,
                labelText: "Enter Address"),
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            controller: salaryController,
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.monetization_on),
                filled: true,
                labelText: "Salary"),
          ),
          SizedBox(
            height: 20,
          ),
          DropdownButton(
              isExpanded: true,
              hint: Text("select designation"),
              value: designation,
              items: designationList
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  designation = value;
                });
              }),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("select Gender"),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Radio<String>(
                      value: "male",
                      groupValue: genderRadioGroup,
                      onChanged: ((value) {
                        setState(() {
                          genderRadioGroup = value!;
                        });
                      })),
                  Text("male"),
                  Radio<String>(
                      value: "Female",
                      groupValue: genderRadioGroup,
                      onChanged: ((value) {
                        setState(() {
                          genderRadioGroup = value!;
                        });
                      })),
                  Text("Female")
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: _selectDate, child: Text("select date of batch")),
              Chip(label: Text(dob == null ? "No date chosen" : dob!))
            ],
          ),
          Column(
            children: [
              Card(
                  child: imagePath == null
                      ? Image.asset(
                          "images/pp.png",
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        )
                      : Image.file(
                          File(imagePath!),
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton.icon(
                      onPressed: () {
                        sourse = ImageSource.camera;
                        getImage();
                      },
                      icon: const Icon(Icons.camera),
                      label: const Text("capture")),
                  TextButton.icon(
                      onPressed: () {
                        sourse = ImageSource.gallery;
                        getImage();
                      },
                      icon: const Icon(Icons.photo),
                      label: const Text("Gallery"))
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  void _selectDate() async {
    final selectDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime.now());
    if (selectDate != null) {
      setState(() {
        dob = DateFormat('dd/mm/yy').format(selectDate);
      });
    }
  }

  void getImage() async {
    final selectedImage = await ImagePicker().pickImage(source: sourse);
    if (selectedImage != null) {
      setState(() {
        imagePath = selectedImage.path;
        print(imagePath);
      });
    }
  }

  void _saveEmployee() {
    if (nameController.text.isEmpty) {
      showMessage(context, "please provide a name for employee");
      return;
    }
    if (mobileController.text.isEmpty) {
      showMessage(context, "please provide a number");
      return;
    }
    if (emailController.text.isEmpty) {
      showMessage(context, "please provide a email");
      return;
    }
    if (addressController.text.isEmpty) {
      showMessage(context, "please provide aaddress");
      return;
    }
    if (salaryController.text.isEmpty) {
      showMessage(context, "please provide salary");
      return;
    }
    if (designation == null) {
      showMessage(context, "please provide designation");
      return;
    }
    final employee = EmployeeModel(
        name: nameController.text,
        dob: dob,
        designation: designation!,
        mobile: mobileController.text,
        email: emailController.text,
        streetAddress: addressController.text,
        salary: num.parse(salaryController.text),
        img: imagePath!,
        gender: genderRadioGroup);
    EmployeeProvider provider =
        Provider.of<EmployeeProvider>(context, listen: false);
    provider.addEmployee(employee);
    // employeeList.add(employee);
    Navigator.pop(context);
  }
}
