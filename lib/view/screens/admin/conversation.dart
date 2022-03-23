import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turu/view/screens/admin/dashboard.dart';
import 'package:turu/view/widgets/admin/admin_conversation_list.dart';

class AdminConversation extends StatefulWidget {
  const AdminConversation({Key? key}) : super(key: key);

  @override
  _AdminConversationState createState() => _AdminConversationState();
}

class _AdminConversationState extends State<AdminConversation> {
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
        body: const AdminConversationsBody(),
      ),
    );
  }
}

class AdminConversationsBody extends StatefulWidget {
  const AdminConversationsBody({Key? key}) : super(key: key);

  @override
  _AdminConversationsBodyState createState() => _AdminConversationsBodyState();
}

class _AdminConversationsBodyState extends State<AdminConversationsBody> {
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

  @override
  Widget build(BuildContext context) {
    return Container(
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
                        'CONVERSATIONS',
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
                  child: Image.asset('assets/images/creativity_pana_1.png'),
                ),
              ],
            ),
            SizedBox(height: 19.h),
            Text(
              'All Conversations',
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
            const AdminConversationsList()
          ],
        ),
      ),
    );
  }
}
