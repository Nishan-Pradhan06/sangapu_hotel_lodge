class TransactionResponse {
  final Summarymodel summary;
  final List<TransactionModel> transactions;

  TransactionResponse({
    required this.summary,
    required this.transactions,
  });

  factory TransactionResponse.fromJson(Map<String, dynamic> json) {
    return TransactionResponse(
      summary: Summarymodel.fromJson(json['summary']),
      transactions: (json['transactions'] as List)
          .map((e) => TransactionModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'summary': summary.toJson(),
      'transactions': transactions.map((e) => e.toJson()).toList(),
    };
  }
}

class Summarymodel {
  final int totalIncome;
  final int totalExpenses;
  final int netBalance;
  final int totalRecords;

  Summarymodel({
    required this.totalIncome,
    required this.totalExpenses,
    required this.netBalance,
    required this.totalRecords,
  });

  factory Summarymodel.fromJson(Map<String, dynamic> json) {
    return Summarymodel(
      totalIncome: json['total_income'] ?? 0,
      totalExpenses: json['total_expenses'] ?? 0,
      netBalance: json['net_balance'] ?? 0,
      totalRecords: json['total_records'] ?? 0,
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

class TransactionModel {
  final int id;
  final String type;
  final String category;
  final int amount;
  final String remarks;
  final String nepaliDate;
  final DateTime createdAt;

  TransactionModel({
    required this.id,
    required this.type,
    required this.category,
    required this.amount,
    required this.remarks,
    required this.nepaliDate,
    required this.createdAt,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      type: json['type'] ?? '',
      category: json['category'] ?? '',
      amount: json['amount'] ?? 0,
      remarks: json['remarks'] ?? '',
      nepaliDate: json['nepali_date'] ?? '',
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'category': category,
      'amount': amount,
      'remarks': remarks,
      'nepali_date': nepaliDate,
      'created_at': createdAt.toIso8601String(),
    };
  }
}