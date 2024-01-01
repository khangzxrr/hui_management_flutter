import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../model/sub_user_model.dart';

class SimpleMemberWidget extends StatelessWidget {
  final SubUserModel subuser;

  const SimpleMemberWidget({super.key, required this.subuser});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 20,
        backgroundImage: CachedNetworkImageProvider(subuser.imageUrl),
      ),
      title: Text("${subuser.name} - ${subuser.nickName}"),
    );
  }
}
