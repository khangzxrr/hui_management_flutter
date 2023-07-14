import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get_it/get_it.dart';
import 'package:hui_management/model/fund_model.dart';
import 'package:hui_management/service/fund_service.dart';

class FundProvider with ChangeNotifier {
  late Fund _fund;

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

  TaskEither<String, bool> addSession(int memberId, double predictPrice) => TaskEither.tryCatch(
        () async => GetIt.I<FundService>().addSession(_fund.id, memberId, predictPrice),
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
