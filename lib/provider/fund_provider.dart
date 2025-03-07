import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get_it/get_it.dart';
import 'package:hui_management/model/fund_member.dart';
import 'package:hui_management/model/fund_model.dart';
import 'package:hui_management/model/fund_report_model.dart';
import 'package:hui_management/service/fund_service.dart';

class FundProvider with ChangeNotifier {
  late Fund _fund;

  List<FundMember> getNotTakenFundMember({required bool includeEmergencyTaken}) {
    final List<int> takenFundMemberIds = [];

    for (final session in _fund.sessions) {
      takenFundMemberIds.addAll(session.getTakenFundMember(includeEmergencyTaken).map((member) => member.id));
    }

    return _fund.members.where((member) => !takenFundMemberIds.contains(member.id)).toList();
  }

  List<FundMember> getTakenFundMember({required bool includeEmergencyTaken}) {
    final List<FundMember> takenFundMember = [];

    for (final session in _fund.sessions) {
      takenFundMember.addAll(session.getTakenFundMember(includeEmergencyTaken));
    }

    return takenFundMember;
  }

  TaskEither<String, FundReportModel> getReport(String reportCode) => TaskEither.tryCatch(
        () async => await GetIt.I<FundService>().getReport(reportCode),
        (error, stackTrace) => error.toString(),
      );

  TaskEither<String, bool> removeFund(int fundId) => TaskEither.tryCatch(
        () async => GetIt.I<FundService>().remove(fundId),
        (error, stackTrace) => error.toString(),
      );

  TaskEither<String, void> getFund(int fundId) => TaskEither.tryCatch(
        () async {
          final fund = await GetIt.I<FundService>().get(fundId);

          _fund = fund;

          notifyListeners();
        },
        (error, stackTrace) {
          log(error.toString(), stackTrace: stackTrace);

          return error.toString();
        },
      );

  TaskEither<String, bool> removeSession(int sessionId) => TaskEither.tryCatch(
        () async => GetIt.I<FundService>().removeSession(_fund.id, sessionId),
        (error, stackTrace) => error.toString(),
      );

  TaskEither<String, bool> addSession(int memberId, double predictPrice) => TaskEither.tryCatch(
        () async => GetIt.I<FundService>().addSession(_fund.id, memberId, predictPrice),
        (error, stackTrace) => error.toString(),
      );

  TaskEither<String, bool> addEmergencySession(int fundId, List<int> memberIds) => TaskEither.tryCatch(
        () async => GetIt.I<FundService>().addEmergencySession(fundId, memberIds),
        (error, stackTrace) => error.toString(),
      );

  TaskEither<String, bool> createFinalSettlementForDeadSession(int fundId, int memberId) => TaskEither.tryCatch(
        () async => GetIt.I<FundService>().createFinalSettlementForDeadSession(fundId, memberId),
        (error, stackTrace) => error.toString(),
      );

  TaskEither<String, bool> removeMember(int memberId) => TaskEither.tryCatch(
        () async => GetIt.I<FundService>().removeMember(_fund.id, memberId),
        (error, stackTrace) => error.toString(),
      );

  TaskEither<String, bool> addMember(int memberId) => TaskEither.tryCatch(() async {
        final addMemberStatus = await GetIt.I<FundService>().addMember(_fund.id, memberId);

        return addMemberStatus;
      }, (error, stackTrace) => error.toString());

  Fund get fund => _fund;
}
