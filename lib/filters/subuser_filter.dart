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

  bool? getProcessingAndDebtPaymentOnly;
  static const getProcessingAndDebtPaymentOnlyName = 'getProcessingAndDebtPaymentOnly';

  SubUserFilter({
    this.atLeastOnePayment,
    this.todayPayment,
    this.searchTerm,
    this.getProcessingAndDebtPaymentOnly,
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
    if (getProcessingAndDebtPaymentOnly != null) {
      filters[getProcessingAndDebtPaymentOnlyName] = 'true';
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
      if (infinityScrollFilter.name == getProcessingAndDebtPaymentOnlyName) {
        filter.getProcessingAndDebtPaymentOnly = true;
      }
    }

    return filter;
  }

  @override
  Set<InfinityScrollFilter> convertToInfinityScrollFilters() {
    return {
      InfinityScrollFilter(
        label: 'Tìm kiếm theo tên hụi viên',
        name: searchTermName,
        textFilter: true,
      ),
      InfinityScrollFilter(
        label: 'Chỉ lọc những hụi viên có ít nhất 1 bill',
        name: atLeastOnePaymentName,
        textFilter: false,
        isShow: false,
        isAlwaysOn: true,
      ),
      InfinityScrollFilter(
        label: 'Chỉ lấy bill nợ và bill đang xử lí',
        name: getProcessingAndDebtPaymentOnlyName,
        textFilter: false,
        isShow: false,
        isAlwaysOn: true,
      ),
      InfinityScrollFilter(
        label: 'Lọc những thanh toán hôm nay',
        name: todayPaymentName,
        textFilter: false,
      ),
      InfinityScrollFilter(
        label: 'Lọc những thanh toán chưa hoàn thành (gồm nợ)',
        name: unfinishedPaymentName,
        textFilter: false,
      ),
    };
  }

  Set<InfinityScrollFilter> convertToMemberInfinityScrollFilters() {
    return {
      InfinityScrollFilter(label: 'Tìm kiếm theo tên hụi viên', name: searchTermName, textFilter: true, isShow: true),
    };
  }
}
