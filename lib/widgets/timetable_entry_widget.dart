part of 'timetable_widget.dart';

class _TimetableEntryWidget extends StatelessWidget {
  final TimetableEntry entry;
  final bool showDetails;
  final bool isFirst;
  final bool isSecond;
  final bool canCatch;

  const _TimetableEntryWidget(
      {super.key,
      required this.entry,
      required this.showDetails,
      required this.isFirst,
      required this.isSecond,
      required this.canCatch});

  @override
  Widget build(BuildContext context) {
    final Color borderColor;
    if (isFirst) {
      borderColor = Colors.yellow;
    } else if (canCatch) {
      borderColor = Colors.pink;
    } else if (isSecond) {
      borderColor = Colors.cyan;
    } else {
      borderColor = Colors.white;
    }
    final Color kindColor;
    final Color destinationColor;
    if (entry.kind.trim() == "急行") {
      kindColor = Colors.orange;
      destinationColor = Colors.orange;
    } else if (entry.destination.trim() == "新田辺") {
      kindColor = Colors.white;
      destinationColor = Colors.lime;
    } else {
      kindColor = Colors.white;
      destinationColor = Colors.white;
    }

    return Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.only(
            top: 8.0, bottom: 8.0, left: 16.0, right: 16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: borderColor, width: 4),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Container(
                  width: 240,
                  alignment: Alignment.center,
                  child: Text(
                    "${twoDigits(entry.hour)}:${twoDigits(entry.minute)}",
                    style: const TextStyle(fontSize: 72),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  entry.kind,
                  style: TextStyle(fontSize: 72, color: kindColor),
                ),
                const SizedBox(width: 8),
                Expanded(
                    child: Center(
                  child: Text(
                    entry.destination,
                    style: TextStyle(fontSize: 72, color: destinationColor),
                  ),
                )),
                const Text(
                  "行",
                  style: TextStyle(fontSize: 40),
                )
              ],
            ),
            if (showDetails)
              Divider(
                thickness: 4,
                color: borderColor,
              ),
            Visibility(
              visible: showDetails,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      if (isFirst)
                        const _Indicator(
                          color: Colors.yellow,
                          label: "先発",
                          sizedWidth: 240,
                        ),
                      if (isFirst) const SizedBox(width: 8),
                      if (isSecond)
                        const _Indicator(
                          color: Colors.cyan,
                          label: "次発",
                          sizedWidth: 240,
                        ),
                      if (isSecond) const SizedBox(width: 8),
                      if (canCatch)
                        const _Indicator(
                          color: Colors.pink,
                          label: "間に合う",
                          sizedWidth: 240,
                        ),
                    ],
                  ),
                  SizedBox(
                    width: 400,
                    child: Text("出発まで ${formatTotalSeconds(entry.remaining)}",
                        style: const TextStyle(fontSize: 40)),
                  )
                ],
              ),
            )
          ],
        ));
  }
}

class _Indicator extends StatelessWidget {
  final int sizedWidth;
  final Color color;
  final String label;

  const _Indicator({
    super.key,
    required this.color,
    required this.label,
    this.sizedWidth = 160,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: sizedWidth.toDouble(),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(60),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
