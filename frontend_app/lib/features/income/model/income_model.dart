class IncomeSummaryResponse {
  final Summary summary;
  final List<IncomeData> data;

  IncomeSummaryResponse({required this.summary, required this.data});

  factory IncomeSummaryResponse.fromJson(Map<String, dynamic> json) {
    return IncomeSummaryResponse(
      summary: Summary.fromJson(json['summary']),
      data: (json['data'] as List).map((e) => IncomeData.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'summary': summary.toJson(),
      'data': data.map((e) => e.toJson()).toList(),
    };
  }
}

class Summary {
  final int totalIncome;
  final int totalExpenses;
  final int netBalance;
  final int totalRecords;

  Summary({
    required this.totalIncome,
    required this.totalExpenses,
    required this.netBalance,
    required this.totalRecords,
  });

  factory Summary.fromJson(Map<String, dynamic> json) {
    return Summary(
      totalIncome: json['total_income'],
      totalExpenses: json['total_expenses'],
      netBalance: json['net_balance'],
      totalRecords: json['total_records'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_income': totalIncome,
      'total_expenses': totalExpenses,
      'net_balance': netBalance,
      'total_records': totalRecords,
    };
  }
}

class IncomeData {
  final String date;
  final int totalEntries;
  final int fixedPriceEntries;
  final int customPriceEntries;
  final int totalIncome;

  IncomeData({
    required this.date,
    required this.totalEntries,
    required this.fixedPriceEntries,
    required this.customPriceEntries,
    required this.totalIncome,
  });

  factory IncomeData.fromJson(Map<String, dynamic> json) {
    return IncomeData(
      date: json['date'],
      totalEntries: json['total_entries'],
      fixedPriceEntries: json['fixed_price_entries'],
      customPriceEntries: json['custom_price_entries'],
      totalIncome: json['total_income'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'total_entries': totalEntries,
      'fixed_price_entries': fixedPriceEntries,
      'custom_price_entries': customPriceEntries,
      'total_income': totalIncome,
    };
  }
}
