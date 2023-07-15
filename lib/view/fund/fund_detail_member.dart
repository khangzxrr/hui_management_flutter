import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class FundDetailMember extends StatelessWidget {
  const FundDetailMember({super.key});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      // The start action pane is the one at the left or the top side.
      startActionPane: ActionPane(
        // A motion is a widget used to control how the pane animates.
        motion: const ScrollMotion(),

        // All actions are defined in the children parameter.
        children: [
          // A SlidableAction can have an icon and/or a label.
          SlidableAction(
            onPressed: (context) {},
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Xóa',
          ),
          SlidableAction(
            onPressed: (context) {},
            backgroundColor: Color.fromARGB(255, 31, 132, 248),
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
              title: Text('Họ và Tên'),
              subtitle: Text('Đã tham gia 8 dây hụi'),
            )
          ],
        ),
      ),
    );
  }
}
