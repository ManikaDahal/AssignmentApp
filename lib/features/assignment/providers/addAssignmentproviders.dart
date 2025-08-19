import 'package:flutter/material.dart';
import 'package:project_1/core/uitils/api_const.dart';
import 'package:project_1/core/uitils/api_response.dart';
import 'package:project_1/core/uitils/dio_http.dart';
import 'package:project_1/core/uitils/status_utils.dart';
import 'package:project_1/features/assignment/model/assignment.dart';



import 'package:shared_preferences/shared_preferences.dart';

class AddAssignmentProvider extends ChangeNotifier {
  List<Assignment> assignmentList = [];
  List<Assignment> _fullAssignmentList = [];


  AddAssignmentProvider() {
    getToken();
  }
  String? token;
  getToken() async {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString('jwt_token');
  }

  List<String> subjectList = [
    "Operating System",
    "DBMS",
    "Web Tech",
    "Cryptography",
    "Computer Science"
  ];

  List<String> semesterList = [
    "1st",
    "2nd",
    "3rd",
    "4th",
    "5th",
    "6th",
    "7th",
    "8th"
  ];

  List<String> facultyList = ["Engineering", "BCA", "BIM", "BIT"];

  // Selected values
  String? selectedSubject;
  String? selectedSemester;
  String? selectedFaculty;
  int? id;

  void setValue(Assignment assignment) {
    id = assignment.id;
    titleController.text = assignment.title ?? "";
    descriptionController.text = assignment.description ?? "";
    setSelectedSubject(assignment.subjectName);
    setSelectedSemester(assignment.semester);
    setSelectedFaculty(assignment.faculty);
  }

  void clear() {
    titleController.text = "";
    descriptionController.text = "";
    selectedSubject = null;
    selectedSemester = null;
    selectedFaculty = null;

    notifyListeners();
  }

  void setSelectedSubject(String? val) {
    selectedSubject = val;
    notifyListeners();
  }

  void setSelectedSemester(String? val) {
    selectedSemester = val;
    notifyListeners();
  }

  void setSelectedFaculty(String? val) {
    selectedFaculty = val;
    notifyListeners();
  }

  // Text controllers
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  StatusUtils addAssignmentStatus = StatusUtils.none;
  StatusUtils getAssignmentStatus = StatusUtils.none;
  StatusUtils deleteAssignmentStatus = StatusUtils.none;

  setGetAsignmentStatus(StatusUtils status) {
    getAssignmentStatus = status;
    notifyListeners();
  }

  setDeleteAsignmentStatus(StatusUtils status) {
    deleteAssignmentStatus = status;
    notifyListeners();
  }

  setAddAsignmentStatus(StatusUtils status) {
    addAssignmentStatus = status;
    notifyListeners();
  }

  void clearFields() {
    selectedSubject = null;
    selectedSemester = null;
    selectedFaculty = null;
    titleController.clear();
    descriptionController.clear();
    notifyListeners();
  }

  Future<void> submitAssignment() async {
    setAddAsignmentStatus(StatusUtils.loading);
    Assignment assignment = Assignment(
        subjectName: selectedSubject,
        semester: selectedSemester,
        faculty: selectedFaculty,
        title: titleController.text.trim(),
        description: descriptionController.text.trim());

    ApiResponse response =
        await postData(Api.addAssignmentApi, assignment.toJson(), token: token);
    if (response.statusUtil == StatusUtils.success) {
      setAddAsignmentStatus(StatusUtils.success);
    } else {
      setAddAsignmentStatus(StatusUtils.error);
    }
  }

void searchAssignments(String query) {

  final lowerQuery = query.toLowerCase();
 if (lowerQuery.isEmpty) {
    assignmentList = _fullAssignmentList.map((e) => e).toList();
  } else {
    assignmentList = _fullAssignmentList.where((assignment) =>
      assignment.subjectName!.toLowerCase().contains(lowerQuery)
    ).toList();
  }

  notifyListeners();
}

  Future<void> getAssignment() async {
    setGetAsignmentStatus(StatusUtils.loading);

    ApiResponse response = await getData(Api.getAssignmentApi, token: token);

    if (response.statusUtil == StatusUtils.success) {
      final newAssignments = (response.data['list'] as List)
          .map((assign) => Assignment.fromJson(assign))
          .toList();

      newAssignments.sort((a, b) => b.id!.compareTo(a.id!)); // descending by id
       _fullAssignmentList = newAssignments;
      assignmentList.addAll(_fullAssignmentList);
      setGetAsignmentStatus(StatusUtils.success);
    } else {
      setGetAsignmentStatus(StatusUtils.error);
    }
  }

  Future<void> deleteAssignment(int id) async {
    setDeleteAsignmentStatus(StatusUtils.loading);
    ApiResponse response =
        await deleteData("${Api.deleteAssignmentApi}/$id", token: token);
    if (response.statusUtil == StatusUtils.success) {
      setDeleteAsignmentStatus(StatusUtils.success);
    } else if (response.statusUtil == StatusUtils.error) {
      setDeleteAsignmentStatus(StatusUtils.error);
    }
  }

  Future<void> updateAssignment() async {
    setAddAsignmentStatus(StatusUtils.loading);
    Assignment assignment = Assignment(
        subjectName: selectedSubject,
        semester: selectedSemester,
        faculty: selectedFaculty,
        title: titleController.text.trim(),
        description: descriptionController.text.trim());
    ApiResponse response = await editData(
        "${Api.editAssignmentApi}/$id", assignment.toJson(),
        token: token);
    if (response.statusUtil == StatusUtils.success) {
      setAddAsignmentStatus(StatusUtils.success);
    } else {
      setAddAsignmentStatus(StatusUtils.error);
    }
  }
}
