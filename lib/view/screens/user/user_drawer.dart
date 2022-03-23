import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turu/view/screens/admin/dashboard.dart';
import 'package:turu/view/screens/user/all_posts.dart';
import 'package:turu/view/screens/user/conversation.dart';
import 'package:turu/view/screens/user/create_a_new_post.dart';
import 'package:turu/view/screens/user/start_page.dart';

class UserDrawer extends StatefulWidget {
  const UserDrawer({Key? key}) : super(key: key);

  @override
  _UserDrawerState createState() => _UserDrawerState();
}

class _UserDrawerState extends State<UserDrawer> {
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
                  _boldText(text: 'All Posts', index: 2),
                  SizedBox(height: 30.h),
                  _boldText(text: 'Create A Post', index: 3),
                  SizedBox(height: 30.h),
                  _boldText(text: 'Chats', index: 4),
                  SizedBox(height: 30.h),
                  _boldText(text: 'Logout', index: 5),
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
        return () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const AllPosts()));
      case 3:
        return () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const Home()));
      case 4:
        return () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const MyConversation()));
      case 5:
        return () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const StartPage()));
      default:
        return () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const AdminDashboard()));
    }
  }
}
