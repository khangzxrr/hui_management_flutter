import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get_it/get_it.dart';
import 'package:hui_management/model/payment_model.dart';
import 'package:hui_management/service/payment_service.dart';

class PaymentProvider with ChangeNotifier {
  List<PaymentModel> _payments = [];

  final paymentService = GetIt.I<PaymentService>();

  TaskEither<String, List<PaymentModel>> getPayments(int ownerId) => TaskEither.tryCatch(
        () async {
          final payments = await paymentService.getPayments(ownerId);
          _payments = payments;

          notifyListeners();

          return _payments;
        },
        (error, stackTrace) => error.toString(),
      );

  List<PaymentModel> get payments => _payments;
}
