class ExpenseResponse {
  final Summary summary;
  final List<Expense> data;

  ExpenseResponse({required this.summary, required this.data});

  factory ExpenseResponse.fromJson(Map<String, dynamic> json) {
    return ExpenseResponse(
      summary: Summary.fromJson(json['summary']),
      data: (json['data'] as List).map((e) => Expense.fromJson(e)).toList(),
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
  final int totalDailyExpenses;
  final int totalMonthlyExpenses;
  final int totalRecords;

  Summary({
    required this.totalDailyExpenses,
    required this.totalMonthlyExpenses,
    required this.totalRecords,
  });

  factory Summary.fromJson(Map<String, dynamic> json) {
    return Summary(
      totalDailyExpenses: json['total_daily_expenses'],
      totalMonthlyExpenses: json['total_monthly_expenses'],
      totalRecords: json['total_records'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_daily_expenses': totalDailyExpenses,
      'total_monthly_expenses': totalMonthlyExpenses,
      'total_records': totalRecords,
    };
  }
}

class Expense {
  final int id;
  final String category;
  final double amount;
  final String remarks;
  final String nepaliDate;
  final DateTime createdAt;
  final DateTime updatedAt;

  Expense({
    required this.id,
    required this.category,
    required this.amount,
    required this.remarks,
    required this.nepaliDate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'],
      category: json['category'],
      amount: double.parse(json['amount'].toString()),
      remarks: json['remarks'],
      nepaliDate: json['nepali_date'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'amount': amount.toStringAsFixed(2),
      'remarks': remarks,
      'nepali_date': nepaliDate,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
