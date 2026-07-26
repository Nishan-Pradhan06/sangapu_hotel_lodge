class NameSplitter {

  static String split(String fullName) {
    if (fullName.trim().isEmpty) return '';

    final parts = fullName.trim().split(RegExp(r'\s+'));

    if (parts.length == 1) return parts.first;

    // First name stays full
    final firstName = parts.first;

    // Rest are converted to initials
    final rest = parts
        .sublist(1)
        .map((part) {
          if (part.length <= 3) {
            return '${_capitalize(part)}.';
          } else {
            return '${part[0].toUpperCase()}.';
          }
        })
        .join(' ');

    return '$firstName $rest';
  }

  static String _capitalize(String input) {
    if (input.isEmpty) return input;
    return input[0].toUpperCase() + input.substring(1).toLowerCase();
  }
}
