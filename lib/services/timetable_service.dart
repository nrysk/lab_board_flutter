import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'package:lab_board/models/timetable_entry.dart';

class TimetableService {
  static const String _timetablePath = "assets/timetable.csv";

  Future<List<TimetableEntry>> loadTimetable() async {
    final raw = await rootBundle.loadString(_timetablePath);
    final data = const CsvToListConverter().convert(raw);
    return data.skip(1).map((e) => TimetableEntry.fromList(e)).toList();
  }
}
