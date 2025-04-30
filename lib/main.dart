import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lab_board/models/beacon_status.dart';
import 'package:lab_board/models/operation_status.dart';
import 'package:lab_board/models/timetable_entry.dart';
import 'package:lab_board/services/beacon_status_service.dart';
import 'package:lab_board/services/operation_status_service.dart';
import 'package:lab_board/services/timetable_service.dart';
import 'package:lab_board/widgets/beacon_status_widget.dart';
import 'package:lab_board/widgets/operation_status_widget.dart';
import 'package:lab_board/widgets/timetable_widget.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ThemeData.dark().colorScheme,
        useMaterial3: true,
      ),
      home: const DashboardPage(),
    );
  }
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final GlobalKey<TimetableWidgetState> _timetableKey = GlobalKey();
  late Timer _timer5min;
  late Timer _timer1min;
  List<TimetableEntry> _timetableEntries = [];
  List<OperationStatus> _operationStatuses = [];
  List<BeaconStatus> _beaconStatuses = [];

  @override
  void initState() {
    super.initState();

    TimetableService().loadTimetable().then((entries) {
      setState(() {
        _timetableEntries = entries;
      });
    });
    OperationStatusService().fetchOperationStatuses().then((statuses) {
      setState(() {
        _operationStatuses = statuses;
      });
    });
    BeaconStatusService().fetchBeaconStatusesByNear(true).then((statuses) {
      setState(() {
        _beaconStatuses = statuses;
      });
    });
    _timer5min = Timer.periodic(const Duration(minutes: 5), (timer) {
      OperationStatusService().fetchOperationStatuses().then((statuses) {
        setState(() {
          _operationStatuses = statuses;
        });
      });
    });
    _timer1min = Timer.periodic(const Duration(seconds: 30), (timer) {
      BeaconStatusService().fetchBeaconStatusesByNear(true).then((statuses) {
        setState(() {
          _beaconStatuses = statuses;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Lab Dashboard"),
          actions: [
            IconButton(
                onPressed: () {
                  _timetableKey.currentState?.scrollToFirstIndex();
                  BeaconStatusService()
                      .fetchBeaconStatusesByNear(true)
                      .then((statuses) {
                    setState(() {
                      _beaconStatuses = statuses;
                    });
                  });
                },
                icon: const Icon(Icons.refresh))
          ],
        ),
        body: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: TimetableWidget(
                      key: _timetableKey,
                      entries: _timetableEntries,
                    ),
                  ),
                  SizedBox(
                    child: OperationStatusWidget(
                      statuses: _operationStatuses,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 450,
              child: BeaconStatusWidget(
                statuses: _beaconStatuses,
              ),
            ),
          ],
        ));
  }

  @override
  void dispose() {
    _timer5min.cancel();
    _timer1min.cancel();
    super.dispose();
  }
}
