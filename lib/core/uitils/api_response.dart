

import 'package:project_1/core/uitils/status_utils.dart';

class ApiResponse {
  StatusUtils? statusUtil;
  dynamic data;
  String? errorMessage;

  ApiResponse({this.data, this.errorMessage, this.statusUtil});
}
