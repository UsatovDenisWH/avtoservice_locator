
extension DateTimeExtension on DateTime {
  String dateToString() {
    return '$year${month < 10 ? 0 : ''}$month${day < 10 ? 0 : ''}$day';
  }
}