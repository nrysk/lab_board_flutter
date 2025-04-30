class TimetableEntry {
  final int hour;
  final int minute;
  final String kind;
  final String destination;
  final int totalSeconds;
  var remaining = 0;

  TimetableEntry(
      {required this.hour,
      required this.minute,
      required this.kind,
      required this.destination})
      : totalSeconds = hour * 3600 + minute * 60;

  factory TimetableEntry.fromList(List<dynamic> list) {
    return TimetableEntry(
      hour: list[0] as int,
      minute: list[1] as int,
      kind: list[2] as String,
      destination: list[3] as String,
    );
  }

  void updateRemaining(int nowTotalSeconds) {
    remaining = totalSeconds - nowTotalSeconds;
  }
}
