class ExpenseResponse {
  final Summary summary;
  final List<Expense> data;

  ExpenseResponse({required this.summary, required this.data});

  factory ExpenseResponse.fromJson(Map<String, dynamic> json) {
    return ExpenseResponse(
      summary: Summary.fromJson(json['summary'] as Map<String, dynamic>),
      data: (json['data'] as List<dynamic>)
          .map((e) => Expense.fromJson(e as Map<String, dynamic>))
          .toList(),
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
  final double totalDailyExpenses;
  final double totalMonthlyExpenses;
  final int totalRecords;

  Summary({
    required this.totalDailyExpenses,
    required this.totalMonthlyExpenses,
    required this.totalRecords,
  });

  factory Summary.fromJson(Map<String, dynamic> json) {
    return Summary(
      totalDailyExpenses: (json['total_daily_expenses'] as num).toDouble(),
      totalMonthlyExpenses: (json['total_monthly_expenses'] as num).toDouble(),
      totalRecords: (json['total_records'] as num).toInt(),
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
      id: (json['id'] as num).toInt(),
      category: json['category'] as String,
      amount: double.parse(json['amount'].toString()),
      remarks: json['remarks'] as String,
      nepaliDate: json['nepali_date'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'amount': amount,
      'remarks': remarks,
      'nepali_date': nepaliDate,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
