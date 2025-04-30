class BeaconStatus {
  final String id;
  final String? nickname;
  final String? univId;
  final bool isProfessor;
  final String name;
  final bool near;

  const BeaconStatus({
    required this.id,
    this.nickname,
    this.univId,
    required this.isProfessor,
    required this.name,
    required this.near,
  });

  factory BeaconStatus.fromJson(Map<String, dynamic> json) {
    return BeaconStatus(
      id: json["id"],
      nickname: json["nickname"],
      univId: json["univId"]?.toString(),
      isProfessor: json["isProfessor"] ?? false,
      name: json["name"] ?? "Unknown",
      near: json["near"],
    );
  }
}
