import 'package:hui_management/filters/filter_interface.dart';
import 'package:hui_management/model/infinity_scroll_filter_model.dart';

class SubUserFilter extends IFilter<SubUserFilter> {
  bool? atLeastOnePayment;
  static const atLeastOnePaymentName = 'atLeastOnePayment';

  bool? todayPayment;
  static const todayPaymentName = 'todayPayment';

  bool? unfinishedPayment;
  static const unfinishedPaymentName = 'unfinishedPayment';

  String? searchTerm;
  static const searchTermName = 'searchTerm';

  SubUserFilter({
    this.atLeastOnePayment,
    this.todayPayment,
    this.searchTerm,
  });

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> filters = {};

    if (atLeastOnePayment != null) {
      filters[atLeastOnePaymentName] = 'true';
    }
    if (todayPayment != null) {
      filters[todayPaymentName] = 'true';
    }
    if (searchTerm != null) {
      filters[searchTermName] = searchTerm.toString();
    }
    if (unfinishedPayment != null) {
      filters[unfinishedPaymentName] = 'true';
    }

    return filters;
  }

  @override
  convertFromInfinityScrollFilter(Set<InfinityScrollFilter> infinityScrollFilters) {
    final SubUserFilter filter = SubUserFilter();

    for (InfinityScrollFilter infinityScrollFilter in infinityScrollFilters) {
      if (infinityScrollFilter.name == atLeastOnePaymentName) {
        filter.atLeastOnePayment = true;
      }
      if (infinityScrollFilter.name == todayPaymentName) {
        filter.todayPayment = true;
      }
      if (infinityScrollFilter.name == searchTermName) {
        filter.searchTerm = infinityScrollFilter.value;
      }
      if (infinityScrollFilter.name == unfinishedPaymentName) {
        filter.unfinishedPayment = true;
      }
    }

    return filter;
  }

  @override
  Set<InfinityScrollFilter> convertToInfinityScrollFilters() {
    return {
      InfinityScrollFilter(label: 'Tìm kiếm theo tên hụi viên', name: searchTermName, textFilter: true),
      InfinityScrollFilter(label: 'Lọc những thanh toán hôm nay', name: todayPaymentName, textFilter: false),
      InfinityScrollFilter(label: 'Lọc những thanh toán chưa hoàn thành (gồm nợ)', name: unfinishedPaymentName, textFilter: false),
    };
  }
}
