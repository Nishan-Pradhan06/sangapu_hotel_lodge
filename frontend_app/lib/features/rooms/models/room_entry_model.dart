class RoomEntryModel {
  final int? fixedPrice;
  final String? customPrice;
  final String? additionalNotes;
  final String nepaliDate;

  const RoomEntryModel({
    this.fixedPrice,
    this.customPrice,
    this.additionalNotes,
    required this.nepaliDate,
  });

  factory RoomEntryModel.fromMap(Map<String, dynamic> map) {
    return RoomEntryModel(
      fixedPrice: map['fixed_price'] as int?,
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
      'fixed_price': fixedPrice,
      'custom_price': customPrice ?? "",
      'additional_notes': additionalNotes ?? "",
      'nepali_date': nepaliDate,
    };
  }

  RoomEntryModel copyWith({
    int? fixedPrice,
    String? customPrice,
    String? additionalNotes,
    String? nepaliDate,
  }) {
    return RoomEntryModel(
      fixedPrice: fixedPrice ?? this.fixedPrice,
      customPrice: customPrice ?? this.customPrice,
      additionalNotes: additionalNotes ?? this.additionalNotes,
      nepaliDate: nepaliDate ?? this.nepaliDate,
    );
  }
}
