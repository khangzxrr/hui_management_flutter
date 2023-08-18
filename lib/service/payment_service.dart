import 'package:get_it/get_it.dart';
import 'package:hui_management/model/payment_model.dart';
import 'package:hui_management/model/user_with_payment_report.dart';

import '../helper/authorize_http.dart';
import '../helper/constants.dart';

class PaymentService {
  final httpClient = GetIt.I<AuthorizeHttp>();

  Future<List<PaymentModel>> getPayments(int ownerId) async {
    final json = await httpClient.getJson('${Constants.apiHostName}/owner/subusers/$ownerId/payments');

    return List<PaymentModel>.from(
      (json['paymentRecords'] as Iterable).map((e) => PaymentModel.fromJson(e)),
    );
  }

  Future addTransaction(UserWithPaymentReport subuser, PaymentModel payment, String transactionMethod, double transactionAmount, String transactionNote) async {
    await httpClient.postJson('${Constants.apiHostName}/owner/subusers/${subuser.id}/payments/${payment.id}/transactions/add', {
      'transactionMethod': transactionMethod,
      'transactionAmount': transactionAmount,
      'transactionNote': transactionNote,
    });
  }
}
