class ExpensesRecordModel {
  final String category;
  final double amount;
  final String remarks;
  final String nepaliDate;

  ExpensesRecordModel({
    required this.category,
    required this.amount,
    required this.remarks,
    required this.nepaliDate,
  });

  factory ExpensesRecordModel.fromJson(Map<String, dynamic> json) {
    return ExpensesRecordModel(
      category: json['category'] as String,
      amount: double.parse(json['amount'].toString()),
      remarks: json['remarks'] as String,
      nepaliDate: json['nepali_date'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      // Send as string since your API expects a string
      'amount': amount.toString(),
      'remarks': remarks,
      'nepali_date': nepaliDate,
    };
  }

  ExpensesRecordModel copyWith({
    String? category,
    double? amount,
    String? remarks,
    String? nepaliDate,
  }) {
    return ExpensesRecordModel(
      category: category ?? this.category,
      amount: amount ?? this.amount,
      remarks: remarks ?? this.remarks,
      nepaliDate: nepaliDate ?? this.nepaliDate,
    );
  }
}
