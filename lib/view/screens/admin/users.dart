import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turu/view/screens/admin/dashboard.dart';
import 'package:turu/view/widgets/admin/admin_users_list.dart';

class AdminUsers extends StatefulWidget {
  const AdminUsers({Key? key}) : super(key: key);

  @override
  _AdminUsersState createState() => _AdminUsersState();
}

class _AdminUsersState extends State<AdminUsers> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: () => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_outlined),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => const AdminDashboard())));
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
        body: const AdminUsersBody(),
      ),
    );
  }
}

class AdminUsersBody extends StatefulWidget {
  const AdminUsersBody({Key? key}) : super(key: key);

  @override
  _AdminUsersBodyState createState() => _AdminUsersBodyState();
}

class _AdminUsersBodyState extends State<AdminUsersBody> {
  List<QueryDocumentSnapshot> usersList = [];

  @override
  void initState() {
    super.initState();
    _fetchUsersData();
  }

  void _fetchUsersData() async {
    await FirebaseFirestore.instance.collection('users').get().then((value) {
      setState(() {
        usersList = value.docs;
      });
    });
  }

  String getMonthName(int month) {
    switch (month) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return 'January';
    }
  }

  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 10), () {
      setState(() {
        _isLoading = false;
      });
    });
    return usersList.isNotEmpty
        ? Container(
            margin: EdgeInsets.only(left: 10.w, right: 10.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'USERS',
                              style: TextStyle(
                                fontSize: 40.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              '${DateTime.now().day} ${getMonthName(DateTime.now().month)}, ${DateTime.now().year}',
                              style: TextStyle(
                                  fontSize: 19.sp,
                                  color: const Color.fromARGB(255, 16, 16, 16)),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child:
                            Image.asset('assets/images/creativity_pana_1.png'),
                      ),
                    ],
                  ),
                  SizedBox(height: 19.h),
                  Text(
                    'All Users',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 19, 62, 85),
                    ),
                  ),
                  SizedBox(height: 7.h),
                  const Divider(
                    thickness: 2,
                  ),
                  SizedBox(height: 30.h),
                  AdminUsersList(
                    users: usersList,
                  ),
                ],
              ),
            ),
          )
        : Center(
            child: _isLoading
                ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor,
                    ),
                  )
                : Center(
                    child: Text(
                      'No Users found to be displayed.',
                      style: TextStyle(
                        fontSize: 24.sp,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
          );
  }
}
