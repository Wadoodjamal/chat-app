import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turu/view/screens/admin/conversation.dart';
import 'package:turu/view/screens/admin/drawer.dart';
import 'package:turu/view/screens/admin/posts.dart';
import 'package:turu/view/screens/admin/users.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int? _numberOfPosts;
  int? _numberOfUsers;
  int? _onHold;
  int? _numberOfConversations;
  bool _isTrue = false;

  void _fetchData() async {
    try {
      final QuerySnapshot postsSnapshot = await FirebaseFirestore.instance
          .collection('allPosts')
          .where('approved', isEqualTo: true)
          .get();
      final QuerySnapshot unApprovedPostsSnapshot = await FirebaseFirestore
          .instance
          .collection('allPosts')
          .where('approved', isEqualTo: false)
          .get();
      final QuerySnapshot conversationsSnapshot =
          await FirebaseFirestore.instance.collection('conversation').get();
      final QuerySnapshot usersSnapshot =
          await FirebaseFirestore.instance.collection('users').get();
      setState(() {
        _numberOfConversations = conversationsSnapshot.docs.length;
        _numberOfUsers = usersSnapshot.docs.length;
        _numberOfPosts = postsSnapshot.docs.length;
        _onHold = unApprovedPostsSnapshot.docs.length;
        _isTrue = true;
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: () => Scaffold(
        key: _scaffoldKey,
        drawer: const AdminDrawer(),
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              _scaffoldKey.currentState!.openDrawer();
            },
          ),
          actions: [
            GestureDetector(
              onTap: () {},
              child: Image.asset(
                'assets/icons/account.png',
                color: Colors.white,
              ),
            ),
            SizedBox(width: 5.w),
          ],
        ),
        body: AdminDashboardBody(
            onHold: _onHold,
            posts: _numberOfPosts,
            users: _numberOfUsers,
            conversations: _numberOfConversations,
            loaded: _isTrue),
      ),
    );
  }
}

class AdminDashboardBody extends StatefulWidget {
  const AdminDashboardBody({
    Key? key,
    this.posts,
    this.onHold,
    this.users,
    this.loaded,
    this.conversations,
  }) : super(key: key);
  final int? posts;
  final int? onHold;
  final int? users;
  final int? conversations;
  final bool? loaded;

  @override
  _AdminDashboardBodyState createState() => _AdminDashboardBodyState();
}

class _AdminDashboardBodyState extends State<AdminDashboardBody> {
  @override
  Widget build(BuildContext context) {
    return widget.loaded == true
        ? Column(
            children: [
              SizedBox(height: 20.h),
              Row(
                children: [
                  SizedBox(width: 20.w),
                  Expanded(
                    child: Text(
                      'Overview',
                      style: TextStyle(
                        fontSize: 40.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 20.w),
                  Expanded(
                    child: Image.asset('assets/images/creativity_pana_1.png'),
                  ),
                ],
              ),
              SizedBox(height: 40.h),
              Row(
                children: [
                  SizedBox(width: 15.w),
                  overviewContainers(
                      title: 'Posts', subtitle: '${widget.posts}'),
                  SizedBox(width: 10.w),
                  overviewContainers(
                      title: 'Conversation',
                      subtitle: '${widget.conversations}'),
                ],
              ),
              SizedBox(height: 40.h),
              Row(
                children: [
                  SizedBox(width: 15.w),
                  overviewContainers(
                      title: 'Users', subtitle: '${widget.users}'),
                  SizedBox(width: 10.w),
                  overviewContainers(
                      title: 'On Hold', subtitle: '${widget.onHold}'),
                ],
              ),
            ],
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }

  GestureDetector overviewContainers({String? title, String? subtitle}) {
    return GestureDetector(
      onTap: () {
        _navigateTo(title: title);
      },
      child: Container(
        height: 150.h,
        width: 170.w,
        decoration: BoxDecoration(
          border: Border.all(
              color: const Color.fromARGB(255, 159, 162, 180), width: 2.w),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title ?? '',
              style: TextStyle(
                fontSize: 19.sp,
                color: const Color.fromARGB(255, 159, 162, 180),
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              subtitle ?? '0',
              style: TextStyle(
                fontSize: 40.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateTo({String? title}) {
    switch (title) {
      case 'Posts':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AdminPosts(),
          ),
        );
        break;
      case 'Users':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AdminUsers(),
          ),
        );
        break;
      case 'Conversation':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AdminConversation(),
          ),
        );
        break;
      case 'On Hold':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AdminPosts(),
          ),
        );
        break;
      default:
        break;
    }
  }
}
