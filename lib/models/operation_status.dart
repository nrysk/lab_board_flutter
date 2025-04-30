enum OperationStatusEnum {
  operating,
  notOperating,
  unknown,
}

class OperationStatus {
  final String lineName;
  final OperationStatusEnum status;

  OperationStatus({required this.lineName, required this.status});

  factory OperationStatus.fromJson(Map<String, dynamic> json) {
    final OperationStatusEnum status;
    switch (json['status']) {
      case 'operating':
        status = OperationStatusEnum.operating;
        break;
      case 'notOperating':
        status = OperationStatusEnum.notOperating;
        break;
      default:
        status = OperationStatusEnum.unknown;
    }
    return OperationStatus(
      lineName: json['line'].toString(),
      status: status,
    );
  }
}
