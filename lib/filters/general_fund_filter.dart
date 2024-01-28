import 'package:hui_management/filters/filter_interface.dart';
import 'package:hui_management/model/infinity_scroll_filter_model.dart';

class GeneralFundFilter extends IFilter<GeneralFundFilter> {
  String? seachTerm;
  static const String searchTermName = 'searchTerm';

  int? bySubuserId;
  static const String bySubuserIdName = 'bySubuserId';

  bool? onlyDayFund;
  static const String onlyDayFundName = 'onlyDayFund';

  bool? onlyMonthFund;
  static const String onlyMonthFundName = 'onlyMonthFundName';

  GeneralFundFilter({this.seachTerm, this.bySubuserId, this.onlyDayFund, this.onlyMonthFund});

  @override
  Set<InfinityScrollFilter> convertToInfinityScrollFilters() {
    return {
      InfinityScrollFilter(label: 'Lọc dây hụi ngày', name: onlyDayFundName, textFilter: false),
      InfinityScrollFilter(label: 'Lọc dây hụi tháng', name: onlyMonthFundName, textFilter: false),
      InfinityScrollFilter(label: 'Lọc dây hụi bởi tên hụi', name: searchTermName, textFilter: true),
    };
  }

  @override
  GeneralFundFilter convertFromInfinityScrollFilter(Set<InfinityScrollFilter> infinityScrollFilters) {
    final GeneralFundFilter filter = GeneralFundFilter();

    for (InfinityScrollFilter isfilter in infinityScrollFilters) {
      if (isfilter.name == searchTermName) {
        filter.seachTerm = isfilter.value;
      }
      if (isfilter.name == onlyDayFundName) {
        filter.onlyDayFund = true;
      }
      if (isfilter.name == onlyMonthFundName) {
        filter.onlyMonthFund = true;
      }
      if (isfilter.name == bySubuserIdName) {
        filter.bySubuserId = isfilter.value as int;
      }
    }

    return filter;
  }

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> filters = {};

    if (seachTerm != null) {
      filters[searchTermName] = seachTerm!;
    }
    if (onlyDayFund != null) {
      filters[onlyDayFundName] = 'true';
    }
    if (onlyMonthFund != null) {
      filters[onlyMonthFundName] = 'true';
    }
    if (bySubuserId != null) {
      filters[bySubuserIdName] = bySubuserId.toString();
    }

    return filters;
  }
}
