import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:intl/intl.dart';

class Utils {
  static final DateFormat dateFormat = DateFormat("dd/MM/yyyy");

  static final NumberFormat moneyFormat = NumberFormat("#,###", "vi");

  static final CurrencyTextInputFormatter currencyTextInputFormatter = CurrencyTextInputFormatter(locale: 'vn', decimalDigits: 0, symbol: 'đ');
}
