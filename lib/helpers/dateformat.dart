import "package:intl/intl.dart";

String formatDate(DateTime date) {
  final formatter = DateFormat('yy-MM-dd');
  return formatter.format(date);
}
