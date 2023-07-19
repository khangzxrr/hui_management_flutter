import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hui_management/model/payment_model.dart';

import '../../helper/utils.dart';

class PaymentPaycheckWidget extends StatelessWidget {
  final PaymentModel payment;

  final formKey = GlobalKey<FormBuilderState>();

  PaymentPaycheckWidget({super.key, required this.payment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Xử lí Bill của ${payment.owner.name} ngày ${Utils.dateFormat.format(payment.createAt)}'),
      ),
      body: Container(
        padding: const EdgeInsets.all(14),
        child: FormBuilder(
          key: formKey,
          child: ListView(
            children: [
              FormBuilderRadioGroup(
                wrapAlignment: WrapAlignment.spaceAround,
                name: 'paymentMethod',
                initialValue: 'byCash',
                decoration: const InputDecoration(labelText: 'Phương thức thanh toán'),
                options: const [
                  FormBuilderFieldOption(value: 'byCash', child: Text('Tiền mặt')),
                  FormBuilderFieldOption(value: 'byCredit', child: Text('Chuyển khoản')),
                  FormBuilderFieldOption(value: 'debt', child: Text('Nợ')),
                ],
                validator: FormBuilderValidators.required(),
              ),
              FormBuilderTextField(
                name: 'note',
                decoration: const InputDecoration(labelText: 'Ghi chú'),
              ),
              const SizedBox(
                height: 14,
              ),
              FilledButton(
                onPressed: () {},
                child: const Text('Lưu thông tin xử lí'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
