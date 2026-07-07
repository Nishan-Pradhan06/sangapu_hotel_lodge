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
      date: json['date'] as String,
      totalEntries: (json['total_entries'] as num).toInt(),
      fixedPriceEntries: (json['fixed_price_entries'] as num).toInt(),
      customPriceEntries: (json['custom_price_entries'] as num).toInt(),
      totalIncome: (json['total_income'] as num).toInt(),
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
