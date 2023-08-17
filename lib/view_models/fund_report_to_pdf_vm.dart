import 'package:hui_management/view_models/taken_member_report_vm.dart';

class FundReportToPdfViewModel {
  String ownerName;
  String ownerAddress;
  String ownerPhoneNumber;
  String ownerBankName;
  String ownerBankAccountNumber;

  String fundName;
  DateTime fundStartDate;
  DateTime fundEndDate;
  int totalMemberCount;
  double serviceCost;
  double lastTakenAmount;
  String nextSessionDateText;
  String nextTakenSessionDeliveryText;
  String newSessionMethodText;
  String warningText;

  List<TakenMemberReportViewModel> takenMemberReportViewModels;

  FundReportToPdfViewModel({
    required this.ownerName,
    required this.ownerAddress,
    required this.ownerPhoneNumber,
    required this.ownerBankName,
    required this.ownerBankAccountNumber,
    required this.fundName,
    required this.fundStartDate,
    required this.fundEndDate,
    required this.totalMemberCount,
    required this.serviceCost,
    required this.lastTakenAmount,
    required this.nextSessionDateText,
    required this.nextTakenSessionDeliveryText,
    required this.newSessionMethodText,
    required this.warningText,
    required this.takenMemberReportViewModels,
  });
}
