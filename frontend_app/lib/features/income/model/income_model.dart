class IncomeSummaryResponse {
  final Summary summary;
  final Pagination pagination;
  final List<IncomeData> data;

  IncomeSummaryResponse({
    required this.summary,
    required this.pagination,
    required this.data,
  });

  factory IncomeSummaryResponse.fromJson(Map<String, dynamic> json) {
    return IncomeSummaryResponse(
      summary: Summary.fromJson(json['summary'] as Map<String, dynamic>),
      pagination: Pagination.fromJson(
        json['pagination'] as Map<String, dynamic>,
      ),
      data: (json['data'] as List<dynamic>)
          .map((e) => IncomeData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'summary': summary.toJson(),
      'pagination': pagination.toJson(),
      'data': data.map((e) => e.toJson()).toList(),
    };
  }
}

class Summary {
  final int totalIncome;
  final int dailyIncome;
  final int monthlyIncome;
  final int totalRecords;

  Summary({
    required this.totalIncome,
    required this.dailyIncome,
    required this.monthlyIncome,
    required this.totalRecords,
  });

  factory Summary.fromJson(Map<String, dynamic> json) {
    return Summary(
      totalIncome: (json['total_income'] as num).toInt(),
      dailyIncome: (json['daily_income'] as num).toInt(),
      monthlyIncome: (json['monthly_income'] as num).toInt(),
      totalRecords: (json['total_records'] as num).toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_income': totalIncome,
      'daily_income': dailyIncome,
      'monthly_income': monthlyIncome,
      'total_records': totalRecords,
    };
  }
}

class Pagination {
  final int count;
  final int totalPages;
  final int currentPage;
  final int perPage;
  final String? next;
  final String? previous;

  Pagination({
    required this.count,
    required this.totalPages,
    required this.currentPage,
    required this.perPage,
    this.next,
    this.previous,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      count: (json['count'] as num).toInt(),
      totalPages: (json['total_pages'] as num).toInt(),
      currentPage: (json['current_page'] as num).toInt(),
      perPage: (json['per_page'] as num).toInt(),
      next: json['next'] as String?,
      previous: json['previous'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'total_pages': totalPages,
      'current_page': currentPage,
      'per_page': perPage,
      'next': next,
      'previous': previous,
    };
  }
}

class IncomeData {
  final int id;
  final String category;
  final int amount;
  final String remarks;
  final String nepaliDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int user;
  final String incomeType;

  IncomeData({
    required this.id,
    required this.category,
    required this.amount,
    required this.remarks,
    required this.nepaliDate,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    required this.incomeType,
  });

  factory IncomeData.fromJson(Map<String, dynamic> json) {
    return IncomeData(
      id: (json['id'] as num).toInt(),
      category: json['category'] as String,
      amount: (json['amount'] as num).toInt(),
      remarks: json['remarks'] as String? ?? '',
      nepaliDate: json['nepali_date'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      user: (json['user'] as num).toInt(),
      incomeType: json['income_type'] as String? ?? '',
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
      'user': user,
      'income_type': incomeType,
    };
  }

  IncomeData copyWith({
    int? id,
    String? category,
    int? amount,
    String? remarks,
    String? nepaliDate,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? user,
    String? incomeType,
  }) {
    return IncomeData(
      id: id ?? this.id,
      category: category ?? this.category,
      amount: amount ?? this.amount,
      remarks: remarks ?? this.remarks,
      nepaliDate: nepaliDate ?? this.nepaliDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      user: user ?? this.user,
      incomeType: incomeType ?? this.incomeType,
    );
  }
}
