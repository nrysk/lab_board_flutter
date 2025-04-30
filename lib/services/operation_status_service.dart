import 'package:lab_board/models/operation_status.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OperationStatusService {
  static const String _operationInfoUrl =
      "http://localhost:8000/operation-info";

  Future<List<OperationStatus>> fetchOperationStatuses() async {
    final List<OperationStatus> operationStatuses = [];
    final response = await http.get(Uri.parse(_operationInfoUrl));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      for (var element in jsonData) {
        final operationStatus = OperationStatus.fromJson(element);
        operationStatuses.add(operationStatus);
      }
    }
    return operationStatuses;
  }
}
