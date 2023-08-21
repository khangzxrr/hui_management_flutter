import 'dart:math';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:intl/intl.dart';

class Utils {
  static final DateFormat dateFormat = DateFormat("dd/MM/yyyy");

  static final DateFormat timeFormat = DateFormat("HH:mm");

  static final NumberFormat moneyFormat = NumberFormat("#,###", "vi");

  static final CurrencyTextInputFormatter currencyTextInputFormatter = CurrencyTextInputFormatter(locale: 'vn', decimalDigits: 0, symbol: 'đ');

  static const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  static final Random _rnd = Random();
  static String getRandomString(int length) => String.fromCharCodes(Iterable.generate(length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
}
