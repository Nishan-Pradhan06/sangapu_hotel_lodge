import 'package:nepali_utils/nepali_utils.dart';

class DateHelper {
  static const List<String> nepaliMonths = [
    'Baishakh',
    'Jestha',
    'Ashadh',
    'Shrawan',
    'Bhadra',
    'Ashwin',
    'Kartik',
    'Mangsir',
    'Poush',
    'Magh',
    'Falgun',
    'Chaitra',
  ];

  static String nepaliDate([DateTime? date]) {
    final bs = (date ?? DateTime.now()).toNepaliDateTime();

    return '${nepaliMonths[bs.month - 1]} ${bs.day}, ${bs.year}';
  }

  static String nepaliDateSlash([DateTime? date]) {
    final bs = (date ?? DateTime.now()).toNepaliDateTime();

    return '${bs.year}/${bs.month.toString().padLeft(2, '0')}/${bs.day.toString().padLeft(2, '0')}';
  }
}
