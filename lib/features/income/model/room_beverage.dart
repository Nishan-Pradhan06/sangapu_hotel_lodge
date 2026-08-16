class RoomBeverage {
  final double roomTotalIncome;
  final double beverageTotalIncome;
  final double totalIncome;
  final double roomTotalExpenses;
  final double beverageTotalExpenses;
  final double totalExpenses;
  final double netTotal;
  final int totalRecords;

  const RoomBeverage({
    required this.roomTotalIncome,
    required this.beverageTotalIncome,
    required this.totalIncome,
    required this.roomTotalExpenses,
    required this.beverageTotalExpenses,
    required this.totalExpenses,
    required this.netTotal,
    required this.totalRecords,
  });

  factory RoomBeverage.fromJson(Map<String, dynamic> json) {
    return RoomBeverage(
      roomTotalIncome: (json['room_total_income'] ?? 0).toDouble(),
      beverageTotalIncome: (json['beverage_total_income'] ?? 0).toDouble(),
      totalIncome: (json['total_income'] ?? 0).toDouble(),
      roomTotalExpenses: (json['room_total_expenses'] ?? 0).toDouble(),
      beverageTotalExpenses: (json['beverage_total_expenses'] ?? 0).toDouble(),
      totalExpenses: (json['total_expenses'] ?? 0).toDouble(),
      netTotal: (json['net_total'] ?? 0).toDouble(),
      totalRecords: json['total_records'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'room_total_income': roomTotalIncome,
      'beverage_total_income': beverageTotalIncome,
      'total_income': totalIncome,
      'room_total_expenses': roomTotalExpenses,
      'beverage_total_expenses': beverageTotalExpenses,
      'total_expenses': totalExpenses,
      'net_total': netTotal,
      'total_records': totalRecords,
    };
  }
}
