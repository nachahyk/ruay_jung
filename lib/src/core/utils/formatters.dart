import 'package:intl/intl.dart';

abstract class Formatters {
  const Formatters._();

  static final _baht = NumberFormat.currency(locale: 'th_TH', symbol: '฿', decimalDigits: 0);
  static final _monthLabel = DateFormat('MMMM yyyy');
  static final _dayLabel = DateFormat('d MMM');

  static String baht(double amount) => _baht.format(amount);

  static String month(DateTime date) => _monthLabel.format(date);

  static String day(DateTime date) => _dayLabel.format(date);
}
