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
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';

class MemberWidget extends StatelessWidget {
  final SubUserModel user;

  const MemberWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<SubUsersProvider>(context, listen: false);

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
              userProvider.removeUser(user.id).andThen(() => userProvider.getAllUsers()).getOrElse((l) {
                log(l);
                DialogHelper.showSnackBar(context, TranslateException.exceptionTranslate[l]!);
              }).run();
            },
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Xóa',
          ),
          SlidableAction(
            onPressed: (context) => context.router.push(MemberEditRoute(isCreateNew: false, user: user)),
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
          onTap: () => context.router.push(MemberEditRoute(isCreateNew: false, user: user)),
          child: Column(
            children: <Widget>[
              ListTile(
                leading: CachedNetworkImage(
                  imageUrl: user.imageUrl,
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
                title: Text(user.name),
                subtitle: Text('CMND/CCCD: ${user.identity}\nSĐT: ${user.phoneNumber}\nNgân hàng: ${user.bankName} - ${user.bankNumber}\nĐịa chỉ: ${user.address}\n${user.additionalInfo}'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MembersListView extends StatelessWidget {
  final List<SubUserModel> users;

  const MembersListView({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: users.map((user) => MemberWidget(user: user)).toList(),
    );
  }
}

@RoutePage()
class MembersScreen extends StatefulWidget {
  const MembersScreen({super.key});

  @override
  State<MembersScreen> createState() => _MembersScreenState();
}

class _MembersScreenState extends State<MembersScreen> {
  String filterText = '';

  @override
  Widget build(BuildContext context) {
    final usersProvider = Provider.of<SubUsersProvider>(context, listen: true);

    final userWidgets = usersProvider.subUsers
        .where(
          (u) => u.toString().replaceAll(' ', '').contains(filterText),
        )
        .map((user) => MemberWidget(user: user))
        .toList();

    return LiquidPullToRefresh(
      onRefresh: () async {
        await usersProvider.getAllUsers().run();
      },
      showChildOpacityTransition: false,
      child: usersProvider.loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(10.0),
              children: [
                Text('Tổng số thành viên: ${usersProvider.subUsers.length}', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(
                  height: 10.0,
                  width: 10.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Tìm kiếm thành viên (tên, sđt, cmnd, địa chỉ, ....))',
                        ),
                        onChanged: (text) {
                          setState(() {
                            filterText = text;
                          });
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          filterText = '';
                        });
                      },
                      icon: const Icon(Icons.clear),
                    ),
                  ],
                ),
                ...userWidgets,
              ],
            ),
    );
    //   );
    //   floatingActionButton: FloatingActionButton(
    //     onPressed: () => context.router.push(MemberEditRoute(isCreateNew: true, user: null)),
    //     backgroundColor: Colors.green,
    //     child: const Icon(Icons.add),
    //   ),
    // );
  }
}
