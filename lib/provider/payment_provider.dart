import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get_it/get_it.dart';
import 'package:hui_management/model/payment_model.dart';
import 'package:hui_management/model/user_with_payment_report.dart';
import 'package:hui_management/service/payment_service.dart';

class PaymentProvider with ChangeNotifier {
  late UserWithPaymentReport selectedUser;
  List<PaymentModel> _payments = [];

  final paymentService = GetIt.I<PaymentService>();

  TaskEither<String, List<PaymentModel>> getPayments(UserWithPaymentReport user) => TaskEither.tryCatch(
        () async {
          final payments = await paymentService.getPayments(user.id);
          _payments = payments;

          selectedUser = user;

          notifyListeners();

          return _payments;
        },
        (error, stackTrace) => error.toString(),
      );

  TaskEither<String, void> addTransaction(PaymentModel payment, String transactionMethod, double transactionAmount, String transactionNote) => TaskEither.tryCatch(() async {
        await paymentService.addTransaction(selectedUser, payment, transactionMethod, transactionAmount, transactionNote);
      }, (error, stackTrace) => error.toString());

  List<PaymentModel> get payments => _payments;
}
