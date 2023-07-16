import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:hui_management/model/payment_model.dart';

import '../helper/authorizeHttp.dart';

class PaymentService {
  final httpClient = GetIt.I<AuthorizeHttp>();

  Future<List<PaymentModel>> getPayments(int ownerId) async {
    final json = await httpClient.getJson('http://localhost:57678/owner/users/$ownerId/payments');

    return List<PaymentModel>.from(
      (json['paymentRecords'] as Iterable).map((e) => PaymentModel.fromJson(e)),
    );
  }
}
