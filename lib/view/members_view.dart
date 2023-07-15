import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get_it/get_it.dart';
import 'package:hui_management/model/user_model.dart';
import 'package:hui_management/provider/users_provider.dart';
import 'package:hui_management/service/user_service.dart';
import 'package:hui_management/view/member_edit.dart';
import 'package:provider/provider.dart';

class MemberWidget extends StatelessWidget {
  late final UserModel user;

  MemberWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UsersProvider>(context, listen: false);

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
              }).run();
            },
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Xóa',
          ),
          SlidableAction(
            onPressed: (context) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MemberEditWidget(isCreateNew: false, user: user),
                ),
              );
            },
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
        child: Column(
          children: <Widget>[
            ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: Image.network('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
              ),
              title: Text(user.name),
              subtitle: Text('${user.email}\n${user.phonenumber}\n${user.bankname} - ${user.banknumber}\n${user.address}\n${user.additionalInfo}'),
            )
          ],
        ),
      ),
    );
  }
}

class MembersWidget extends StatelessWidget {
  const MembersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final usersProvider = Provider.of<UsersProvider>(context);

    final List<Widget> userWidgets = [];

    userWidgets.addAll(
      usersProvider.users.map((user) => MemberWidget(user: user)),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lí thành viên'),
      ),
      body: ListView(
        children: userWidgets,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MemberEditWidget(isCreateNew: true, user: null),
            ),
          );
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }
}
