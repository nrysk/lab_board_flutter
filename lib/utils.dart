import 'dart:ui';

String twoDigits(int n) => n.toString().padLeft(2, '0');

String formatDuration(Duration duration) {
  String twoDigitHours = twoDigits(duration.inHours.remainder(24));
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return "$twoDigitHours:$twoDigitMinutes:$twoDigitSeconds";
}

String formatTotalSeconds(int totalSeconds) {
  String twoDigitHours = twoDigits(totalSeconds ~/ 3600);
  String twoDigitMinutes = twoDigits((totalSeconds % 3600) ~/ 60);
  String twoDigitSeconds = twoDigits(totalSeconds % 60);
  return "$twoDigitHours:$twoDigitMinutes:$twoDigitSeconds";
}

Color hashStringToColor(String str) {
  int hash = str.hashCode;
  return Color.fromARGB(
    255,
    (hash & 0xFF0000) >> 16,
    (hash & 0x00FF00) >> 8,
    hash & 0x0000FF,
  );
}
