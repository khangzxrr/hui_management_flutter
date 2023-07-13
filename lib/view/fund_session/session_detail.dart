import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SessionDetailMember extends StatelessWidget {
  final bool isTakeFund;
  const SessionDetailMember({super.key, required this.isTakeFund});

  @override
  Widget build(BuildContext context) {
    const takeFundText = 'Thăm kêu: 2.000\nTiền hụi: 109.992.000\nTrừ Thảo: 5.000.000\nCòn lại: 104.992.000\nTiền hụi chết: 40.000.000';
    const notTakeFundText = 'Tiền đóng: 10.000.000\nTiền hụi chết: 40.000.000';

    return Card(
      color: isTakeFund ? Theme.of(context).primaryColor : Theme.of(context).cardColor,
      child: Column(
        children: <Widget>[
          ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: Image.network('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
            ),
            title: Text(
              'Họ và Tên',
              style: TextStyle(color: isTakeFund ? Colors.white : Colors.black),
            ),
            subtitle: Text(isTakeFund ? takeFundText : notTakeFundText, textAlign: TextAlign.right, style: TextStyle(color: isTakeFund ? Colors.white : Colors.black)),
          )
        ],
      ),
    );
  }
}

class SessionDetailWidget extends StatelessWidget {
  const SessionDetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('dây hụi abc Kì 1'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SessionDetailMember(isTakeFund: true),
              SessionDetailMember(isTakeFund: false),
            ],
          ),
        ),
      ),
    );
  }
}
