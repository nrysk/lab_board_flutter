import 'package:flutter/material.dart';
import 'package:lab_board/models/beacon_status.dart';
import 'package:lab_board/utils.dart';

class BeaconStatusWidget extends StatelessWidget {
  final List<BeaconStatus> statuses;

  const BeaconStatusWidget({super.key, required this.statuses});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 4.0),
      decoration: const BoxDecoration(color: Color.fromARGB(255, 39, 39, 39)),
      child: Column(children: [
        const Center(
          child: Text(
            "近くに居る",
            style: TextStyle(
              fontSize: 24,
            ),
          ),
        ),
        Wrap(
          children: [
            for (var status in statuses)
              Container(
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.all(8.0),
                width: 200,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: status.isProfessor
                      ? Colors.deepPurple
                      : Colors.deepOrange,
                  // hashStringToColor(status.univId?.substring(0, 4) ?? ""),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  status.nickname ?? status.name,
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              )
          ],
        )
      ]),
    );
  }
}
