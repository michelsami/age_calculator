import 'package:intl/intl.dart';

class DateFormatter {
  static String dateFormatted(DateTime dateNotFormatted) {
    String dateAfterFormat = DateFormat("dd-MM-yyyy").format(dateNotFormatted);
    return dateAfterFormat;
  }
}
