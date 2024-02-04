import 'package:get_it/get_it.dart';
import 'package:hui_management/model/payment_model.dart';

import '../helper/authorize_http.dart';
import '../helper/constants.dart';

class PaymentService {
  final httpClient = GetIt.I<AuthorizeHttp>();

  Future addCustomBill({required int subuserId, required double amount, required String customBillType, required String description}) async {
    await httpClient.postJson(
      '${Constants.apiHostName}/owner/subusers/$subuserId/payments/custom-bills/add',
      {
        'customBillType': customBillType,
        'amount': amount,
        'description': description,
      },
    );
  }

  Future<List<PaymentModel>> getPayments({required int ownerId, int? sessionDetailId}) async {
    final json = await httpClient.getJson('${Constants.apiHostName}/owner/subusers/$ownerId/payments');

    return List<PaymentModel>.from(
      (json['paymentRecords'] as Iterable).map((e) => PaymentModel.fromJson(e)),
    );
  }

  Future addTransaction(PaymentModel payment, String transactionMethod, double transactionAmount, String transactionNote) async {
    await httpClient.postJson('${Constants.apiHostName}/owner/subusers/${payment.owner.id}/payments/${payment.id}/transactions/add', {
      'transactionMethod': transactionMethod,
      'transactionAmount': transactionAmount,
      'transactionNote': transactionNote,
    });
  }
}
