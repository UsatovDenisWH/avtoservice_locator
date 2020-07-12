extension DateTimeExtension on DateTime {
  String dateToStringForJson() {
    return '$year${month < 10 ? 0 : ''}$month${day < 10 ? 0 : ''}$day';
  }

  String dateToStringForHuman() {
    String result;
    if (this == null) {
      result = null;
    } else {
      result = '${day < 10 ? 0 : ''}$day.${month < 10 ? 0 : ''}$month.$year';
    }
    return result;
  }
}
