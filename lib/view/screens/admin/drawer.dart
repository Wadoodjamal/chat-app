import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turu/view/screens/admin/conversation.dart';
import 'package:turu/view/screens/admin/dashboard.dart';
import 'package:turu/view/screens/admin/posts.dart';
import 'package:turu/view/screens/admin/users.dart';
import 'package:turu/view/screens/user/start_page.dart';

class AdminDrawer extends StatefulWidget {
  const AdminDrawer({Key? key}) : super(key: key);

  @override
  _AdminDrawerState createState() => _AdminDrawerState();
}

class _AdminDrawerState extends State<AdminDrawer> {
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: ScreenUtil().setWidth(260),
        child: Scaffold(
          body: Drawer(
            key: _drawerKey,
            backgroundColor: Theme.of(context).primaryColor,
            child: Container(
              margin: EdgeInsets.all(40.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _boldText(text: 'Profile', index: 1),
                  SizedBox(height: 30.h),
                  _boldText(text: 'Dashboard', index: 2),
                  SizedBox(height: 30.h),
                  _boldText(text: 'Posts', index: 3),
                  SizedBox(height: 30.h),
                  _boldText(text: 'Users', index: 4),
                  SizedBox(height: 30.h),
                  _boldText(text: 'Conversations', index: 5),
                  SizedBox(height: 30.h),
                  _boldText(text: 'Logout', index: 6),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector _boldText({String? text, int? index, BuildContext? context}) {
    return GestureDetector(
      onTap: _navigateTo(index ?? 2),
      child: Text(
        text ?? '',
        style: TextStyle(
          fontSize: ScreenUtil().setSp(24),
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  VoidCallback _navigateTo(int index) {
    switch (index) {
      case 2:
        return () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => const AdminDashboard()));
      case 3:
        return () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => const AdminPosts()));
      case 4:
        return () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => const AdminUsers()));
      case 5:
        return () => Navigator.push(context,
            MaterialPageRoute(builder: (_) => const AdminConversation()));
      case 6:
        return () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => const StartPage()));
      default:
        return () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => const AdminDashboard()));
    }
  }
}
