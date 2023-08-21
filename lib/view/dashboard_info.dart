import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/authentication_provider.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    final authenticationProvider = Provider.of<AuthenticationProvider>(context, listen: true); //must not listen to avoid infinite loop;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
            child: Column(
              children: [
                const SizedBox(height: 100, width: 10),
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
                AutoSizeText(
                  textAlign: TextAlign.center,
                  'Ngân hàng giao dịch: ${authenticationProvider.model!.subUser.bankName} - ${authenticationProvider.model!.subUser.bankNumber}',
                  style: const TextStyle(fontSize: 18),
                  maxLines: 1,
                ),
                const SizedBox(height: 10, width: 15),
                Text(
                  textAlign: TextAlign.center,
                  authenticationProvider.model!.subUser.additionalInfo,
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: -85,
          width: 170,
          child: SizedBox(
            width: 170,
            height: 170,
            child: CachedNetworkImage(
              imageUrl: authenticationProvider.model!.subUser.imageUrl,
              imageBuilder: (context, imageProvider) => Container(
                width: 170.0,
                height: 170.0,
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
        ),
      ],
    );
  }
}

@RoutePage()
class DashboardInfoScreen extends StatelessWidget {
  const DashboardInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: NetworkImage('https://picsum.photos/800/800'),
        fit: BoxFit.cover,
      )),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.4)),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [InfoCard()],
          ),
        ),
      ),
    );
  }
}
