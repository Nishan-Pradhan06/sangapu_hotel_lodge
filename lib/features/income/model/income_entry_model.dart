class IncomeEntryModel {
  final String incomeType;
  final int? regularPrice;
  final String? customPrice;
  final String? additionalNotes;
  final String nepaliDate;

  const IncomeEntryModel({
    required this.incomeType,
    this.regularPrice,
    this.customPrice,
    this.additionalNotes,
    required this.nepaliDate,
  });

  factory IncomeEntryModel.fromMap(Map<String, dynamic> map) {
    return IncomeEntryModel(
      incomeType: map['income_type'] as String,
      regularPrice: (map['regular_price'] as num?)?.toInt(),
      customPrice: (map['custom_price'] as String?)?.isEmpty == true
          ? null
          : map['custom_price'] as String?,
      additionalNotes: (map['additional_notes'] as String?)?.isEmpty == true
          ? null
          : map['additional_notes'] as String?,
      nepaliDate: map['nepali_date'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'income_type': incomeType,
      'regular_price': regularPrice,
      'custom_price': customPrice ?? '',
      'additional_notes': additionalNotes ?? '',
      'nepali_date': nepaliDate,
    };
  }

  IncomeEntryModel copyWith({
    String? incomeType,
    int? regularPrice,
    String? customPrice,
    String? additionalNotes,
    String? nepaliDate,
  }) {
    return IncomeEntryModel(
      incomeType: incomeType ?? this.incomeType,
      regularPrice: regularPrice ?? this.regularPrice,
      customPrice: customPrice ?? this.customPrice,
      additionalNotes: additionalNotes ?? this.additionalNotes,
      nepaliDate: nepaliDate ?? this.nepaliDate,
    );
  }
}
