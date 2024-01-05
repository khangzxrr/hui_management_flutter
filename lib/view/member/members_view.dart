import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hui_management/helper/dialog.dart';
import 'package:hui_management/helper/translate_exception.dart';
import 'package:hui_management/model/sub_user_model.dart';
import 'package:hui_management/provider/sub_users_provider.dart';
import 'package:hui_management/routes/app_route.dart';
import 'package:hui_management/view/abstract_view/infinity_scroll_widget.dart';
import 'package:provider/provider.dart';

class MemberWidget extends StatelessWidget {
  final SubUserModel subuser;

  const MemberWidget({super.key, required this.subuser});

  @override
  Widget build(BuildContext context) {
    final subuserProvider = Provider.of<SubUsersProvider>(context, listen: false);

    return Slidable(
      // The start action pane is the one at the left or the top side.
      startActionPane: ActionPane(
        // A motion is a widget used to control how the pane animates.
        motion: const ScrollMotion(),

        // All actions are defined in the children parameter.
        children: [
          // A SlidableAction can have an icon and/or a label.
          SlidableAction(
            onPressed: (context) async {
              subuserProvider
                  .removeUser(subuser.id)
                  .andThen(
                    () => subuserProvider.refreshPagingTaskEither(),
                  )
                  .match((l) {
                log(l);
                DialogHelper.showSnackBar(context, TranslateException.exceptionTranslate[l]!);
              }, (r) {}).run();
            },
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Xóa',
          ),
          SlidableAction(
            onPressed: (context) => context.router.push(MemberEditRoute(isCreateNew: false, user: subuser)),
            backgroundColor: const Color.fromARGB(255, 31, 132, 248),
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Chỉnh sửa',
          ),
        ],
      ),

      // The child of the Slidable is what the user sees when the
      // component is not dragged.
      child: Card(
        child: InkWell(
          onTap: () => context.router.push(MemberEditRoute(isCreateNew: false, user: subuser)),
          child: Column(
            children: <Widget>[
              ListTile(
                dense: true,
                leading: CachedNetworkImage(
                  imageUrl: subuser.imageUrl,
                  imageBuilder: (context, imageProvider) => Container(
                    width: 80.0,
                    height: 80.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(image: imageProvider, fit: BoxFit.scaleDown),
                    ),
                  ),
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                title: Text('${subuser.name} - ${subuser.nickName}'),
                subtitle: Text('CMND/CCCD: ${subuser.identity}\nSĐT: ${subuser.phoneNumber}\nNgân hàng: ${subuser.bankName} - ${subuser.bankNumber}\nĐịa chỉ: ${subuser.address}\n${subuser.additionalInfo}'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

@RoutePage()
class MembersScreen extends StatelessWidget {
  const MembersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final subuserProvider = Provider.of<SubUsersProvider>(context, listen: true);

    return InfinityScrollWidget<SubUserModel>(
      paginatedProvider: subuserProvider,
      filters: {},
      widgetItemFactory: (subuser) => MemberWidget(subuser: subuser),
    );
  }
}
