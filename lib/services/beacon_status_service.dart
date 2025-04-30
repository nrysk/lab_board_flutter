import 'package:lab_board/models/beacon_status.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BeaconStatusService {
  static const String _beaconInfoUrl = "http://localhost:8000/beacon-info";

  Future<List<BeaconStatus>> fetchBeaconStatuses() async {
    final List<BeaconStatus> beaconStatuses = [];
    final response = await http.get(Uri.parse(_beaconInfoUrl));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      for (var element in jsonData) {
        final beaconStatus = BeaconStatus.fromJson(element);
        beaconStatuses.add(beaconStatus);
      }
    }

    return beaconStatuses;
  }

  Future<List<BeaconStatus>> fetchBeaconStatusesByNear(bool near) async {
    final List<BeaconStatus> beaconStatuses = await fetchBeaconStatuses();
    return beaconStatuses.where((status) => status.near == near).toList();
  }
}
