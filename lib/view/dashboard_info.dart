import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/authentication_provider.dart';

@RoutePage()
class DashboardInfoScreen extends StatelessWidget {
  const DashboardInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authenticationProvider = Provider.of<AuthenticationProvider>(context, listen: true); //must not listen to avoid infinite loop;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 5, width: 5),
        SizedBox(
          width: 200,
          height: 200,
          child: CachedNetworkImage(
            imageUrl: authenticationProvider.model!.subUser.imageUrl,
            imageBuilder: (context, imageProvider) => Container(
              width: 100.0,
              height: 100.0,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            ),
            placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
        const SizedBox(height: 10, width: 10),
        Text(
          textAlign: TextAlign.center,
          authenticationProvider.model!.subUser.name,
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5, width: 5),
        AutoSizeText(
          textAlign: TextAlign.center,
          'Địa chỉ: ${authenticationProvider.model!.subUser.address}',
          style: const TextStyle(fontSize: 18),
          maxLines: 1,
        ),
        const SizedBox(height: 5, width: 5),
        Text(
          textAlign: TextAlign.center,
          'Số điện thoại: ${authenticationProvider.model!.subUser.phoneNumber}',
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 5, width: 5),
        Text(
          textAlign: TextAlign.center,
          'Ngân hàng giao dịch: ${authenticationProvider.model!.subUser.bankName} - ${authenticationProvider.model!.subUser.bankNumber}',
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 10, width: 15),
        Text(
          textAlign: TextAlign.center,
          authenticationProvider.model!.subUser.additionalInfo,
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}
