import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get_it/get_it.dart';
import 'package:hui_management/model/payment_model.dart';
import 'package:hui_management/service/payment_service.dart';

class PaymentProvider with ChangeNotifier {
  List<PaymentModel> _payments = [];

  final paymentService = GetIt.I<PaymentService>();

  TaskEither<String, void> addCustomBill({
    required int subuserId,
    required double amount,
    required String customBillType,
    required String description,
  }) =>
      TaskEither.tryCatch(
        () async => await paymentService.addCustomBill(
          subuserId: subuserId,
          amount: amount,
          customBillType: customBillType,
          description: description,
        ),
        (error, stackTrace) => error.toString(),
      );

  TaskEither<String, List<PaymentModel>> getPaymentsFilterBy({required int subUserId, int? sessionDetailId}) => TaskEither.tryCatch(
        () async => await paymentService.getPayments(ownerId: subUserId, sessionDetailId: sessionDetailId),
        (error, stackTrace) => error.toString(),
      );

  TaskEither<String, List<PaymentModel>> getPayments(int subUserId) => TaskEither.tryCatch(
        () async {
          final payments = await paymentService.getPayments(ownerId: subUserId);
          _payments = payments;

          notifyListeners();

          return _payments;
        },
        (error, stackTrace) => error.toString(),
      );

  TaskEither<String, void> addTransaction(PaymentModel payment, String transactionMethod, double transactionAmount, String transactionNote) => TaskEither.tryCatch(() async {
        await paymentService.addTransaction(payment, transactionMethod, transactionAmount, transactionNote);
      }, (error, stackTrace) => error.toString());

  List<PaymentModel> get payments => _payments;
}
