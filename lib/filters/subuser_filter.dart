import 'package:hui_management/filters/filter_interface.dart';
import 'package:hui_management/model/infinity_scroll_filter_model.dart';

class SubUserFilter extends IFilter<SubUserFilter> {
  bool? atLeastOnePayment;
  static const atLeastOnePaymentName = 'atLeastOnePayment';

  bool? todayPayment;
  static const todayPaymentName = 'todayPayment';

  String? searchTerm;
  static const searchTermName = 'searchTerm';

  int? byPaymentId;
  static const byPaymentIdName = 'byPaymentId';

  SubUserFilter({
    this.atLeastOnePayment,
    this.todayPayment,
    this.searchTerm,
    this.byPaymentId,
  });

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> filters = {};

    if (atLeastOnePayment != null) {
      filters['atLeastOnePayment'] = 'true';
    }
    if (todayPayment != null) {
      filters['todayPayment'] = 'true';
    }
    if (searchTerm != null) {
      filters['searchTerm'] = searchTerm.toString();
    }
    if (byPaymentId != null) {
      filters['byPaymentId'] = byPaymentId.toString();
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
      if (infinityScrollFilter.name == byPaymentIdName) {
        filter.searchTerm = infinityScrollFilter.value;
      }
    }

    return filter;
  }

  @override
  Set<InfinityScrollFilter> convertToInfinityScrollFilters() {
    return {
      InfinityScrollFilter(label: 'Tìm kiếm theo tên hụi viên', name: searchTermName, textFilter: true),
      InfinityScrollFilter(label: 'Những thanh toán hôm nay', name: todayPaymentName, textFilter: false),
    };
  }
}
