import 'package:flutter/material.dart';
import 'package:project_1/core/uitils/assignment.dart';
import 'package:project_1/core/uitils/status_utils.dart';
import 'package:project_1/core/uitils/api_response.dart';
import 'package:project_1/core/uitils/api_const.dart';
import 'package:project_1/core/uitils/dio_http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddAssignmentProvider extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController subjectNameController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  String selectedFaculty = 'BCA';
  String selectedSemester = 'First Semester';

  final List<String> facultyOptions = ['BCA', 'BIM', 'CSIT'];
  final List<String> semesterOptions = [
    'First Semester',
    'Second Semester',
    'Third Semester',
    'Fourth Semester',
    'Fifth Semester',
    'Sixth Semester',
    'Seventh Semester',
  ];

  StatusUtils submitStatus = StatusUtils.none;

  void setSubmitStatus(StatusUtils status) {
    submitStatus = status;
    notifyListeners();
  }

  Future<void> submitAssignment() async {
    if (!formKey.currentState!.validate()) return;

    final assignment = Assignment(
      subjectName: subjectNameController.text,
      semester: selectedSemester,
      faculty: selectedFaculty,
      title: titleController.text,
      description: descriptionController.text,
    );

    setSubmitStatus(StatusUtils.loading);
    // Fetch token from SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');


    ApiResponse response = await postData(Api.addAssignment, assignment.toJson(),token: token);

    if (response.statusUtil == StatusUtils.success) {
      setSubmitStatus(StatusUtils.success);
    } else {
      setSubmitStatus(StatusUtils.error);
    }
  }
}
