import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:turu/view/screens/admin/users.dart';
import 'package:turu/view/widgets/admin/admin_user_item.dart';

class AdminUsersList extends StatefulWidget {
  const AdminUsersList({Key? key, this.users}) : super(key: key);

  final List<QueryDocumentSnapshot>? users;

  @override
  _AdminUsersListState createState() => _AdminUsersListState();
}

class _AdminUsersListState extends State<AdminUsersList> {
  void _onDelete(value) async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(widget.users![value].id)
        .delete();

    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AdminUsers()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: () => ListView.builder(
        itemCount: widget.users?.length ?? 0,
        shrinkWrap: true,
        itemBuilder: ((context, index) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AdminUserItem(
                  currentIndex: index,
                  name: widget.users![index].get('name'),
                  onDelete: _onDelete,
                ),
                SizedBox(height: ScreenUtil().setHeight(20)),
              ],
            )),
      ),
    );
  }
}
