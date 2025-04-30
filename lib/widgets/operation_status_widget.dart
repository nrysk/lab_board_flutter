import 'package:flutter/material.dart';
import 'package:lab_board/models/operation_status.dart';

class OperationStatusWidget extends StatelessWidget {
  final List<OperationStatus> statuses;

  const OperationStatusWidget({super.key, required this.statuses});

  @override
  Widget build(BuildContext context) {
    return Wrap(children: [
      for (var status in statuses)
        Container(
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: status.status == OperationStatusEnum.operating
                  ? Colors.green
                  : status.status == OperationStatusEnum.notOperating
                      ? Colors.red
                      : Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
            height: 80,
            width: 240,
            child: Text(
              status.lineName,
              style: const TextStyle(
                fontSize: 40,
                color: Colors.white,
              ),
            ))
    ]);
  }
}
