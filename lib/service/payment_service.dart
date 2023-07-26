import 'package:get_it/get_it.dart';
import 'package:hui_management/model/payment_model.dart';

import '../helper/authorizeHttp.dart';
import '../helper/constants.dart';

class PaymentService {
  final httpClient = GetIt.I<AuthorizeHttp>();

  Future<List<PaymentModel>> getPayments(int ownerId) async {
    final json = await httpClient.getJson('${Constants.apiHostName}/owner/users/$ownerId/payments');

    return List<PaymentModel>.from(
      (json['paymentRecords'] as Iterable).map((e) => PaymentModel.fromJson(e)),
    );
  }

  Future addTransaction(PaymentModel payment, String transactionMethod, double transactionAmount, String transactionNote) async {
    await httpClient.postJson('${Constants.apiHostName}/owner/users/${payment.owner.id}/payments/${payment.id}/transactions/add', {
      'transactionMethod': transactionMethod,
      'transactionAmount': transactionAmount,
      'transactionNote': transactionNote,
    });
  }
}
