import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:project_1/core/uitils/status_utils.dart';
import 'package:project_1/core/uitils/api_const.dart';
import 'package:project_1/core/uitils/dio_http.dart';
import 'package:project_1/core/uitils/api_response.dart';

class GetAssignmentProvider extends ChangeNotifier {
  List<Map<String, dynamic>> assignments = [];
  StatusUtils getAssignmentStatus = StatusUtils.none;

  /// Set the current fetch status and notify listeners
  void setGetAssignmentStatus(StatusUtils status) {
    getAssignmentStatus = status;
    notifyListeners();
  }

  /// Fetch assignments from API using token
  Future<void> getAssignments() async {
    setGetAssignmentStatus(StatusUtils.loading);

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('jwt_token');

      final ApiResponse response = await getData(Api.getAssignment, token: token);

      if (response.statusUtil == StatusUtils.success && response.data != null) {
        assignments = (response.data as List)
            .map((e) => e as Map<String, dynamic>)
            .toList();
        setGetAssignmentStatus(StatusUtils.success);
      } else {
        assignments = [];
        setGetAssignmentStatus(StatusUtils.error);
      }
    } catch (e) {
      assignments = [];
      setGetAssignmentStatus(StatusUtils.error);
    }
  }

  /// Optional: Clear assignments list and status
  void clearAssignments() {
    assignments = [];
    getAssignmentStatus = StatusUtils.none;
    notifyListeners();
  }
}
