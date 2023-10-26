import 'package:intl/intl.dart';

extension DateExtension on DateTime {
  String formattedDate({String format = 'dd MMMM yyyy'}) =>
      DateFormat(format).format(this);
}
