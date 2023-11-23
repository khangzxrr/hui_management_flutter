class TranslateException {
  static String translate(String source) => exceptionTranslate[source] == null ? "Lỗi chưa xác định: $source" : exceptionTranslate[source]!;

  static Map<String, String> exceptionTranslate = {
    'Exception: FUND_NOT_HAVE_ANY_SESSION_YET': 'Hụi chưa có kì khui nào trước đó, vui lòng khui ít nhất 1 kì trước khi thực hiện hành động này!',
    'Exception: USER_HAS_BILLS_OR_ATTEND_IN_FUNDS': 'Người dùng đã có giao dịch trong hụi\nvui lòng xóa các giao dịch trước và xóa người dùng khỏi các dây hụi',
  };
}
