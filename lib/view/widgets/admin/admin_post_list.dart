import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:turu/view/screens/admin/posts.dart';
import 'package:turu/view/widgets/admin/admin_post_item.dart';

class AdminPostList extends StatefulWidget {
  const AdminPostList({
    Key? key,
    this.list,
  }) : super(key: key);

  final List<QueryDocumentSnapshot>? list;

  @override
  _AdminPostListState createState() => _AdminPostListState();
}

class _AdminPostListState extends State<AdminPostList> {
  @override
  void initState() {
    super.initState();
  }

  bool isApproved = false;

  void _setIsApproved(value) async {
    await FirebaseFirestore.instance
        .collection('allPosts')
        .doc(widget.list![value].id)
        .update({'approved': !isApproved});
  }

  void _setIsDelete(value) async {
    FirebaseFirestore.instance
        .collection('allPosts')
        .doc(widget.list![value].id)
        .delete();

    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AdminPosts()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: () => ListView.builder(
        itemCount: widget.list?.length ?? 0,
        shrinkWrap: true,
        itemBuilder: ((context, index) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AdminPostItem(
                  time: (widget.list![index].data()
                      as Map<String, dynamic>)['time'],
                  title: (widget.list![index].data()
                      as Map<String, dynamic>)['title'],
                  id: index,
                  onApproved: _setIsApproved,
                  onDelete: _setIsDelete,
                ),
                SizedBox(height: ScreenUtil().setHeight(20)),
              ],
            )),
      ),
    );
  }
}
